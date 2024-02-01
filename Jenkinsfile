
pipeline {
    agent any

    environment {
        CAM_IP = '192.168.20.202'   // camera
        LNX_IP = '192.168.20.199'   // profiler
        OTHER_IP = '192.168.20.159'    // profiler virtual
        DEB_PACKAGE = 'Mech-Eye_API_2.3.0_amd64.deb'  // cpp package
        WHEEL_PACKAGE = 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl'  // wheel python3.8

        WORKSPACE = 'MMIND_TEST_Python_CI'
        REPO_URL = 'https://github.com/changlelian/MechMindAPICI.git'
        PIP_MIRRORS = 'https://pypi.tuna.tsinghua.edu.cn/simple'
    }

    stages {
        stage('Clone test code'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '2c5b2149-4914-4b15-bd7a-af703dddf0da', url: 'https://github.com/changlelian/MechMindAPIPyCI.git']])
            }
        }

        stage('Test Python37-311 Environmet') {
            steps {
                script {
                    pythonVersionInstall('venv37', 'MechEyeAPI-2.3.0-cp37-cp37m-manylinux_2_27_x86_64.whl')
                    pythonVersionInstall('venv38', 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl')
                    pythonVersionInstall('venv39', 'MechEyeAPI-2.3.0-cp39-cp39-manylinux_2_27_x86_64.whl')
                    pythonVersionInstall('venv310', 'MechEyeAPI-2.3.0-cp310-cp310-manylinux_2_27_x86_64.whl')
                    pythonVersionInstall('venv311', 'MechEyeAPI-2.3.0-cp311-cp311-manylinux_2_27_x86_64.whl')
                }
            }
        }
    }
}

def pythonVersionInstall(envVersion, pyAPIVsersion){
    sh "bash -c 'source /home/mech_mind_sdk/py_env/${envVersion}/bin/activate'"
    sh "bash -c 'python3 -m pip install --upgrade pip -i ${PIP_MIRRORS}'"
    sh "bash -c 'python3 -m pip uninstall mecheyeapi --yes'"
    sh "bash -c 'python3 -m pip install ${pyAPIVsersion} -i ${PIP_MIRRORS}'"
    sh "bash -c 'python3 /var/lib/jenkins/workspace/${WORKSPACE}/TestPythonInstall/print_camera_info.py ${CAM_IP}'"
    sh "bash -c 'deactivate'"
}