
pipeline {
    agent any

    // triggers {
    //     cron('H 0,3,5,22 * * *')
    // }

    environment {
        CAM_IP = '192.168.20.120'   // camera
        LNX_IP = '192.168.20.90'   // profiler
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

        stage('Test Build Samples'){
            parallel {
                stage('Test Build AMD64 Samples') {
                    agent {
                        label 'mm_amd64'
                    }

                    steps {
                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                            script {
                                sh "sudo sh /var/lib/jenkins/workspace/${WORKSPACE}/TestBuildSamples/build_amd_samples.sh"
                            }
                        }
                    }
                }

                stage('Test Build ARM64 Samples') {
                    agent {
                        label 'mm_arm64'
                    }

                    steps {
                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                            script {
                                sh "sudo sh /home/nvidia/CI/jenkins_workspace/workspace/${WORKSPACE}/TestBuildSamples/build_amd_samples.sh"
                            }
                        }
                    }
                }

                stage('Test Build Windows Samples') {
                    agent {
                        label 'mm_windows'
                    }

                    steps {
                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                            script {
                                bat "E:\\jenkins_workspace\\workspace\\${WORKSPACE}\\TestBuildSamples\\build_win_samples.bat"
                            }
                        }
                    }
                }                  
            }           
        }

        stage('Test Amd64 Python37-311 Environmet') {
            agent {
                label 'mm_amd64'
            }

            steps {
                script {
                    pythonVersionAmd64Install('venv37', 'MechEyeAPI-2.3.0-cp37-cp37m-manylinux_2_27_x86_64.whl')
                    pythonVersionAmd64Install('venv38', 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_x86_64.whl')
                    pythonVersionAmd64Install('venv39', 'MechEyeAPI-2.3.0-cp39-cp39-manylinux_2_27_x86_64.whl')
                    pythonVersionAmd64Install('venv310', 'MechEyeAPI-2.3.0-cp310-cp310-manylinux_2_27_x86_64.whl')
                    pythonVersionAmd64Install('venv311', 'MechEyeAPI-2.3.0-cp311-cp311-manylinux_2_27_x86_64.whl')
                }
            }
        }

        stage('Test Arm64 Python37-311 Environmet') {
            agent {
                label 'mm_arm64'
            }

            steps {
                script {
                    pythonVersionArm64Install('venv37', 'MechEyeAPI-2.3.0-cp37-cp37m-manylinux_2_27_aarch64.whl')
                    pythonVersionArm64Install('venv38', 'MechEyeAPI-2.3.0-cp38-cp38-manylinux_2_27_aarch64.whl')
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

def pythonVersionAmd64Install(envVersion, pyAPIVsersion){
    sh ". /home/mech_mind_sdk/py_env/${envVersion}/bin/activate"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip install --upgrade pip -i ${PIP_MIRRORS}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip uninstall mecheyeapi --yes"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 -m pip install /var/lib/jenkins/workspace/${pyAPIVsersion} -i ${PIP_MIRRORS}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 /var/lib/jenkins/workspace/${WORKSPACE}/TestPythonInstall/print_camera_info.py ${CAM_IP}"
    sh "sudo /home/mech_mind_sdk/py_env/${envVersion}/bin/python3 /var/lib/jenkins/workspace/${WORKSPACE}/TestPythonInstall/print_profiler_info.py ${LNX_IP}"

}

def pythonVersionArm64Install(envVersion, pyAPIVsersion){
    sh ". /home/nvidia/CI/py_env/${envVersion}/bin/activate"
    sh "sudo /home/nvidia/CI/py_env/${envVersion}/bin/python3 -m pip install --upgrade pip -i ${PIP_MIRRORS}"
    sh "sudo /home/nvidia/CI/py_env/${envVersion}/bin/python3 -m pip uninstall mecheyeapi --yes"
    sh "sudo /home/nvidia/CI/py_env/${envVersion}/bin/python3 -m pip install /home/nvidia/CI/python_wheels/${pyAPIVsersion} -i ${PIP_MIRRORS}"
    sh "sudo /home/nvidia/CI/py_env/${envVersion}/bin/python3 /home/nvidia/CI/jenkins_workspace/workspace/${WORKSPACE}/TestPythonInstall/print_camera_info.py ${CAM_IP}"
    sh "sudo /home/nvidia/CI/py_env/${envVersion}/bin/python3 /home/nvidia/CI/jenkins_workspace/workspace/${WORKSPACE}/TestPythonInstall/print_profiler_info.py ${LNX_IP}"

}



def pythonVersionWindowsInstall(envVersion, pyAPIVsersion){
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\activate"
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\pip.exe install ${WINDOWS_VENV_PATH}\\python_wheels\\${pyAPIVsersion}"
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\python.exe ${WINDOWS_JENKINS_WORKSPACE}\\workspace\\MMIND_TEST_Python_CI_main\\TestPythonInstall\\print_camera_info.py ${CAM_IP}"
    bat "${WINDOWS_VENV_PATH}\\${envVersion}\\Scripts\\python.exe ${WINDOWS_JENKINS_WORKSPACE}\\workspace\\MMIND_TEST_Python_CI_main\\TestPythonInstall\\print_profiler_info.py ${LNX_IP}"
}

