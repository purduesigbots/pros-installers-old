// Note: this jenkinsfile isn't actually used
stage('Build') {
    parallel(
        'windows': {
            node('windows&&advinst') {
                stage('Download files') {
                    checkout poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'GitLFSPull']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '280afe18-e491-4424-8f05-05c45b48a154', url: 'git@github.com:purduesigbots/pros-installers.git']]]
                    step([$class: 'CopyArtifact', filter: 'out/pros-editor*windows.zip', fingerprintArtifacts: true, flatten: true, projectName: 'PROS/atom', selector: [$class: 'ParameterizedBuildSelector', parameterName: 'ATOM_BUILD_SELECTOR']])
                    step([$class: 'CopyArtifact', filter: 'out/pros_cli-*-win-*.zip,out/*', fingerprintArtifacts: true, flatten: true, projectName: "${CLI_PROJECT_SELECTOR}", selector: [$class: 'ParameterizedBuildSelector', parameterName: 'CLI_BUILD_SELECTOR']])
                }

                stage('Extract files') {
                    powershell '7z x .\\pros-editor-64-windows.zip -o".\\pros-editor-64-windows"'
                    powershell '7z x .\\pros-editor-windows.zip -o".\\pros-editor-32-windows"'
                    powershell '7z x .\\pros_cli-*-win-64bit.zip -o".\\pros-cli-64-windows"'
                    powershell '7z x .\\pros_cli-*-win-32bit.zip -o".\\pros-cli-32-windows"'
                }

                stage('Update installers') {
                    bat 'powershell -ExecutionPolicy Bypass -File .\\Add-Installer-Components.ps1'
                } 
                
                stage('Manual final preparation') {
                    build_agent_ip = powershell returnStdout: true, script: '(Test-Connection -ComputerName (hostname) -Count 1).IPv4Address.IPAddressToString'
                    emailext body: """The build agent is on ${build_agent_ip}. Go to ${BUILD_URL} to approve.""", 
                            subject: 'Configure Digital Signature for Windows Installers (${BUILD_NUMBER})', 
                            to: 'edjubuh@gmail.com'
                    try {
                        timeout(time: 5, unit: 'HOURS') { // change to a convenient timeout for you
                            input(message: 'Finalize installers')
                        }
                    } catch(err) { // timeout reached or input false
                        def user = err.getCauses()[0].getUser()
                        if('SYSTEM' != user.toString()) { // SYSTEM means timeout.
                        } else {
                            echo "Aborted by: [${user}]"
                            throw err
                        }
                    } // end of catch
                }

                stage('Build Installers') {
                    bat 'powershell -ExecutionPolicy Bypass -file .\Build-Installer.ps1'
                    archiveArtifacts 'output/'
                }
            } // end node
        }
    )
}