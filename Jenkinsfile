
pipeline {
    agent any

    environment {
        CAM_IP = '192.168.20.2'   // camera
        LNX_IP = '192.168.20.199'   // profiler
        OTHER_IP = '192.168.20.159'    // profiler virtual
        DEB_PACKAGE = 'Mech-Eye_API_2.3.0_amd64.deb'  // cpp package
        WHEEL_PACKAGE = 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl'  // wheel python3.8

        WINDOWS_JENKINS_WORKSPACE = 'E:\\jenkins_workspace\\workspace'
        WINDOWS_VENV_PATH = 'E:\\jenkins_workspace\\workspace\\python_environment'
        
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

        // stage('Test Amd Python37-311 Environmet') {
        //     agent {
        //         label 'mm_amd64'
        //     }

        //     steps {
        //         script {
        //             pythonVersionInstall('venv37', 'MechEyeAPI-2.3.0-cp37-cp37m-manylinux_2_27_x86_64.whl')
        //             pythonVersionInstall('venv38', 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl')
        //             pythonVersionInstall('venv39', 'MechEyeAPI-2.3.0-cp39-cp39-manylinux_2_27_x86_64.whl')
        //             pythonVersionInstall('venv310', 'MechEyeAPI-2.3.0-cp310-cp310-manylinux_2_27_x86_64.whl')
        //             pythonVersionInstall('venv311', 'MechEyeAPI-2.3.0-cp311-cp311-manylinux_2_27_x86_64.whl')
        //         }
        //     }
        // }

        stage('Test Windows Python37-311 Environmet') {
            agent {
                label 'mm_windows'
            }
            steps {
                // Windows相关的构建步骤
                bat 'echo Running on Windows'
                bat "${WINDOWS_VENV_PATH}\\venv10\\Scripts\\activate"
                bat "${WINDOWS_VENV_PATH}\\venv10\\Scripts\\pip.exe install ${WINDOWS_VENV_PATH}\\python_wheels\\MechEyeAPI-2.3.0-cp310-cp310-win_amd64.whl"
                bat "${WINDOWS_VENV_PATH}\\venv10\\Scripts\\python.exe ${WINDOWS_JENKINS_WORKSPACE}\\MMIND_TEST_Python_CI_main\\TestPythonInstall\\print_camera_info.py ${CAM_IP}"
            }
        }       
    }
}

def pythonVersionInstall(envVersion, pyAPIVsersion){
    sh ". /home/mech_mind_sdk/py_env/${envVersion}/bin/activate"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip install --upgrade pip -i ${PIP_MIRRORS}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip uninstall mecheyeapi --yes"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip install /var/lib/jenkins/workspace/${pyAPIVsersion} -i ${PIP_MIRRORS}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 /var/lib/jenkins/workspace/${WORKSPACE}/TestPythonInstall/print_camera_info.py ${CAM_IP}"
    // sh "deactivate"
}