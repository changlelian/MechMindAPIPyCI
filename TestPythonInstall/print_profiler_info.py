import sys
from mecheye.shared import *
from mecheye.profiler import *
from mecheye.profiler_utils import *


class PrintProfilerInfo(object):
    def __init__(self, ip):
        self.ip = ip
        self.camera = Profiler()
        self.camera_info = ProfilerInfo()

    def print_device_info(self):
        show_error(self.camera.get_profiler_info(self.camera_info))
        print_profiler_info(self.camera_info)


    def main(self):
        self.camera.connect(self.ip)    
        self.print_device_info()
        self.camera.disconnect()
        print("Disconnected from the camera successfully.")



if __name__ == '__main__':
    a = PrintProfilerInfo(sys.argv[1])
    a.main()
