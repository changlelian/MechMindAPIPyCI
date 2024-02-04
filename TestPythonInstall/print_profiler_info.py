import sys
from mecheye.shared import *
from mecheye.profiler import *
from mecheye.profiler_utils import *

def print_profiler_info1(profiler_info: ProfilerInfo):
    print(".........................................")
    print("Profiler Model Name:           ", profiler_info.model)
    print("Controller Serial Number:      ", profiler_info.controller_sn)
    print("Sensor Serial Number:          ", profiler_info.sensor_sn)
    print("Profiler IP Address:           ", profiler_info.ip_address)
    print("Profiler IP Subnet Mask:       ", profiler_info.subnet_mask)
    print("Profiler IP Assignment Method: ", ip_assignment_method_to_string(profiler_info.ip_assignment_method))
    print("Hardware Version:              V", profiler_info.hardware_version.to_string())
    print("Firmware Version:              V", profiler_info.firmware_version.to_string())
    print(".........................................")
    print()


class PrintProfilerInfo(object):
    def __init__(self, ip):
        self.ip = ip
        self.profiler = Profiler()
        self.profiler_info = ProfilerInfo()

    def print_device_info(self):
        show_error(self.profiler.get_profiler_info(self.profiler_info))
        print_profiler_info1(self.profiler_info)


    def main(self):
        self.profiler.connect(self.ip)    
        self.print_device_info()
        self.profiler.disconnect()
        print("Disconnected from the profiler successfully.")



if __name__ == '__main__':
    a = PrintProfilerInfo(sys.argv[1])
    a.main()
