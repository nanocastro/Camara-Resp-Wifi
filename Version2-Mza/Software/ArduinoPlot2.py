'''
Copyright 2020 Pablo Cremades
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

**************************************************************************************
* Autor: Pablo Cremades
* Fecha: 19/08/2020
* e-mail: pablocremades@gmail.com
* Descripción: Este programa muestra cómo crear un hilo para leer el puerto serie y pasar los datos al hilo principal.
*
* Change Log:
* -
'''

from PyQt5 import QtCore, QtWidgets
from PyQt5.QtWidgets import QVBoxLayout, QHBoxLayout
import serial
import serial.tools.list_ports
import sys
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
from matplotlib import style
import matplotlib.pyplot as plt
from collections import deque
import itertools
from time import sleep
from scipy import stats
import numpy as np


class serialEvent(QtCore.QThread):
    '''
    Esta clase implementa el hilo que se ejecuta en background para leer el puerto serie.

    Las Signals deben crearse en la definición de la clase/subclase, no como atributo
    después de creada la clase. Es decir, deben ser atributos de la clase, no de cada instancia
    '''
    dataReady = QtCore.pyqtSignal(str)

    def __init__(self, puerto):
        super().__init__()
        print(puerto)
        baudRate =9600
        self.ser = serial.Serial(puerto, baudRate)
        # The following snipet of code resets the arduino and flushes any data sent, avoiding exceptions being generated.
        self.ser.setDTR(False)
        sleep(1)
        # toss any data already received, see
        # http://pyserial.sourceforge.net/pyserial_api.html#serial.Serial.flushInput
        self.ser.flushInput()
        self.ser.setDTR(True)
        self.listenPort = True

    # Bucle infinito hasta que @listenPort es False
    def run(self):
        while self.listenPort:
            datosSerial = self.ser.read_until()
            self.dataReady.emit(datosSerial.decode('ascii'))
        self.ser.close()
        return  # Termina el hilo

    # This function stops the thread. This is called when function run() returns.
    def stop(self):
        self.listenPort = False


class Canvas(FigureCanvas):
    '''
    Esta clase genera la figura.
    '''
    def __init__(self, parent=None, width=5, height=4):
        self.fig = Figure(figsize=(width, height), dpi=100)
        self.axes = self.fig.add_subplot(111)
        cid = self.fig.canvas.mpl_connect('button_press_event', self.onclick)
        super().__init__(self.fig)

    def onclick(event):
        print("click")


class myWindow(QtWidgets.QWidget):
    MAX_DATOS = 100

    def __init__(self, *argv, **kwargv):
        super().__init__(*argv, **kwargv)
        self.SetupUI()
        # Estas colas almacenan los datos que vienen por el puerto serie.
        # deque tiene métodos más rápido para implementar buffers circulares
        # que las listas comunes de Python
        self.tiempo = deque([], maxlen=myWindow.MAX_DATOS)
        self.amplitud = deque([], maxlen=myWindow.MAX_DATOS)
        self.linRegress = []

    def SetupUI(self):
        self.setFixedSize(700, 500)  # Ventana de tamaño fijo
        self.setWindowTitle("Arduino Plot Data")

        # Este timer sirve para actualizar la figura. No se puede actualizar el gráfico
        # cada vez que llegan datos por puerto serie porque es muy costos generar el gráfico
        # muchas veces por segundo.
        timer = QtCore.QTimer(self)
        timer.timeout.connect(self.updatePlot)
        timer.start(30)

        # Set plot style
        plt.style.use('seaborn')

        # Un Layout vertical con un Layout horizontal en la primera fila
        vLayout = QVBoxLayout()
        hLayout = QHBoxLayout()

        puertoLabel = QtWidgets.QLabel("Puerto: ")

        hLayout.addWidget(puertoLabel)

        self.puertosSelect = QtWidgets.QComboBox()
        for puerto in serial.tools.list_ports.comports(include_links=False):  # Busca los puertos y los agrega a la lista
            self.puertosSelect.addItem(puerto.device)
        self.puertosSelect.adjustSize()

        hLayout.addWidget(self.puertosSelect)
        
        self.conectar = QtWidgets.QPushButton("Conectar")
        if(self.puertosSelect.count() == 0):
            self.conectar.setDisabled(True)  # Deshabilita el botón si no encuentra puertos
        else:
            puerto = self.puertosSelect.currentText()
            self.conectar.clicked.connect(lambda puerto: self.conectarArduino(puerto))
        hLayout.addWidget(self.conectar)

        self.desconectar = QtWidgets.QPushButton("Desconectar")
        self.desconectar.setDisabled(True)
        self.desconectar.clicked.connect(self.desconectarArduino)
        hLayout.addWidget(self.desconectar)

        self.calcularRL = QtWidgets.QPushButton("Calcular")
        self.calcularRL.clicked.connect(self.calcLinRegress)
        self.calcularRL.setDisabled(True)
        hLayout.addWidget(self.calcularRL)

        self.exportar = QtWidgets.QPushButton("Exportar CSV")
        self.exportar.clicked.connect(self.exportarCSV)
        self.exportar.setDisabled(True)
        hLayout.addWidget(self.exportar)

        self.saveFig = QtWidgets.QPushButton("Salvar Figura")
        self.saveFig.clicked.connect(self.exportFig)
        self.saveFig.adjustSize()
        self.saveFig.setDisabled(True)
        hLayout.addWidget(self.saveFig)

        self.minRange = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.maxRange = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.minRange.sliderMoved.connect(self.minRangeMoved)
        self.maxRange.sliderMoved.connect(self.maxRangeMoved)
        self.minRange.setDisabled(True)
        self.maxRange.setDisabled(True)

        hLayout1 = QHBoxLayout()
        hLayout1.addWidget(self.minRange)
        hLayout1.addWidget(self.maxRange)

        vLayout.addLayout(hLayout)
        vLayout.addLayout(hLayout1)

        self.plotCanvas = Canvas(self)

        vLayout.addWidget(self.plotCanvas)

        self.setLayout(vLayout)

        self.show()
        
    def conectarArduino(self, puerto):
        '''
        Esta función inicia el hilo que lee los datos del puerto serie.
        '''
        puerto = self.puertosSelect.currentText()
        self.serialThread = serialEvent(puerto)
        self.serialThread.dataReady.connect(self.processData)  # Conecta la señal a la función que procesa los datos.
        self.serialThread.start()
        self.tiempo.clear()
        self.amplitud.clear()
        self.linRegress = []  # Borramos la regresión lineal para recibir nuevos datos.
        self.desconectar.setEnabled(True)
        self.conectar.setDisabled(True)  # Deshabilita el botón después de que se ha conectado.
        self.calcularRL.setDisabled(True) # Deshabilita el botón.
        self.exportar.setDisabled(True)
        self.minRange.setDisabled(True)
        self.maxRange.setDisabled(True)
        self.saveFig.setDisabled(True)
        self.minRange.setRange(0, 0)
        self.maxRange.setRange(0, 0)

    def desconectarArduino(self):
        self.desconectar.setDisabled(True)
        self.conectar.setEnabled(True)
        self.calcularRL.setEnabled(True)
        self.exportar.setEnabled(True)
        # Lets set the sliders max and min positions
        meanValue = int(len(self.tiempo)/2)
        self.minRange.setMinimum(0)
        self.minRange.setMaximum(meanValue - 1)
        self.minRange.setValue(self.minRange.minimum())
        self.maxRange.setMinimum(meanValue + 1)
        self.maxRange.setMaximum(len(self.tiempo))
        self.maxRange.setValue(self.minRange.maximum())
        self.minRange.setEnabled(True)
        self.maxRange.setEnabled(True)
        self.saveFig.setEnabled(True)
        self.close()
        print("Cerramos el puerto")
        
    def processData(self, datos):
        '''
        This function is executed every time new data is available on the
        serial port. See the serial thread above.
        '''
        try:
            datosSplit = datos.split()
            if(len(datosSplit) >= 2):
                tiempoCast = float(datosSplit[0]) / 1000.0
                valorCast = float(datosSplit[1])
                self.tiempo.append(tiempoCast)
                self.amplitud.append(valorCast)
        except ValueError:
            print("Error en el string")
            pass

    def updatePlot(self):
        '''
        Esta función actualiza el gráfico. El método no es muy eficiente porque borra la
        figura y la vuelve a generar.
        '''
        self.plotCanvas.axes.clear()
        self.plotRef = self.plotCanvas.axes.plot(self.tiempo, self.amplitud, ".r")
        self.plotCanvas.axes.set_xlabel("Tiempo [s]")
        self.plotCanvas.axes.set_ylabel("CO2 [ppm]")
        if len(self.linRegress) > 0:
            self.plotCanvas.axes.plot(self.tiempo,
                                      self.linRegress.slope * np.array(self.tiempo) +
                                      self.linRegress.intercept)
            self.plotCanvas.axes.text(self.tiempo[0], self.amplitud[-1],
                                      str(round(self.linRegress.slope, 2)) +
                                      "*x +" +
                                      str(round(self.linRegress.intercept, 2)))
        if(len(self.tiempo) > 0):
            self.plotCanvas.axes.plot([self.tiempo[self.minRange.value()],
                                       self.tiempo[self.minRange.value()]],
                                      [self.plotCanvas.axes.get_ylim()[0],
                                       self.plotCanvas.axes.get_ylim()[1]],
                                      '-g')
            self.plotCanvas.axes.plot([self.tiempo[self.maxRange.value()],
                                       self.tiempo[self.maxRange.value()]],
                                      [self.plotCanvas.axes.get_ylim()[0],
                                       self.plotCanvas.axes.get_ylim()[1]],
                                      '-g')
        self.plotCanvas.draw()

    def close(self):
        '''
        Antes de salir, detiene el hilo y espera a que se ejecute el último ciclo del
        bucle
        '''
        self.serialThread.stop()
        self.serialThread.wait()

    def calcLinRegress(self):
        minimo = int(self.minRange.value())
        maximo = int(self.maxRange.value())

        tiempo = list(itertools.islice(self.tiempo, minimo, maximo))
        amplitud = list(itertools.islice(self.amplitud, minimo, maximo))

        self.linRegress = stats.linregress(tiempo, amplitud)

    def exportarCSV(self):
        np.savetxt("datos.csv",
                   np.column_stack((self.tiempo, self.amplitud)),
                   fmt='%.1f', delimiter=',', header="tiempo,amplitud")

    def exportFig(self):
        self.plotCanvas.fig.savefig("figura.png", dpi=150)


    def minRangeMoved(self):
        pass
        self.maxRange.setMinimum(self.minRange.value() + 1)
    #    print("Minimo: ", self.minRange.minimum(), ", ", self.minRange.maximum())
    #    print("Maximo: ", self.maxRange.minimum(), ", ", self.maxRange.maximum())

    def maxRangeMoved(self):
        pass
        self.minRange.setMaximum(self.maxRange.value() - 1)

if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    win = myWindow()
    status = app.exec_()
    sys.exit(status)
