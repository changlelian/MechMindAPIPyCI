
pipeline {
    agent any

    triggers {
        cron('H 0,3,5,22 * * *')
    }

    environment {
        CAM_IP = '192.168.20.2'   // camera
        LNX_IP = '192.168.20.199'   // profiler
        OTHER_IP = '192.168.20.159'    // profiler virtual
        DEB_PACKAGE = 'Mech-Eye_API_2.3.0_amd64.deb'  // cpp package
        WHEEL_PACKAGE = 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl'  // wheel python3.8

        WINDOWS_JENKINS_WORKSPACE = 'E:\\jenkins_workspace'
        WINDOWS_VENV_PATH = 'C:\\Users\\mech-mind_lcl\\Desktop\\python_environment'
        
        WORKSPACE = 'MMIND_TEST_Python_CI_main'
        REPO_URL = 'https://github.com/changlelian/MechMindAPICI.git'
        PIP_MIRRORS = 'https://pypi.tuna.tsinghua.edu.cn/simple'
    }

    stages {
        stage('Clone test code'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '2c5b2149-4914-4b15-bd7a-af703dddf0da', url: 'https://github.com/changlelian/MechMindAPIPyCI.git']])
            }
        }

        stage('Test Amd Python37-311 Environmet') {
            agent {
                label 'mm_amd64'
            }

            steps {
                script {
                    pythonVersionLinuxInstall('venv37', 'MechEyeAPI-2.3.0-cp37-cp37m-manylinux_2_27_x86_64.whl')
                    pythonVersionLinuxInstall('venv38', 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl')
                    pythonVersionLinuxInstall('venv39', 'MechEyeAPI-2.3.0-cp39-cp39-manylinux_2_27_x86_64.whl')
                    pythonVersionLinuxInstall('venv310', 'MechEyeAPI-2.3.0-cp310-cp310-manylinux_2_27_x86_64.whl')
                    pythonVersionLinuxInstall('venv311', 'MechEyeAPI-2.3.0-cp311-cp311-manylinux_2_27_x86_64.whl')
                }
            }
        }

        stage('Test Windows Python37-311 Environmet') {
            agent {
                label 'mm_windows'
            }
            steps {
                pythonVersionWindowsInstall('venv37', 'MechEyeAPI-2.3.0-cp37-cp37m-win_amd64.whl')
                pythonVersionWindowsInstall('venv38', 'MechEyeAPI-2.3.0-cp38-cp38-win_amd64.whl')
                pythonVersionWindowsInstall('venv39', 'MechEyeAPI-2.3.0-cp39-cp39-win_amd64.whl')
                pythonVersionWindowsInstall('venv10', 'MechEyeAPI-2.3.0-cp310-cp310-win_amd64.whl')
                pythonVersionWindowsInstall('venv311', 'MechEyeAPI-2.3.0-cp311-cp311-win_amd64.whl')

            }
        }       
    }
}

def pythonVersionLinuxInstall(envVersion, pyAPIVsersion){
    sh ". /home/mech_mind_sdk/py_env/${envVersion}/bin/activate"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip install --upgrade pip -i ${PIP_MIRRORS}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip uninstall mecheyeapi --yes"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip install /var/lib/jenkins/workspace/${pyAPIVsersion} -i ${PIP_MIRRORS}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 /var/lib/jenkins/workspace/${WORKSPACE}/TestPythonInstall/print_camera_info.py ${CAM_IP}"
    // sh "deactivate"
}


def pythonVersionWindowsInstall(envVersion, pyAPIVsersion){
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\activate"
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\pip.exe install ${WINDOWS_VENV_PATH}\\python_wheels\\${pyAPIVsersion}"
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\python.exe ${WINDOWS_JENKINS_WORKSPACE}\\workspace\\MMIND_TEST_Python_CI_main\\TestPythonInstall\\print_camera_info.py ${CAM_IP}"
}