// Note: this jenkinsfile isn't actually used

stage('Build') {
    parallel(
        'windows': {
            node('windows&&advinst') {
                checkout poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '280afe18-e491-4424-8f05-05c45b48a154', url: 'git@github.com:purduesigbots/pros-installers.git']]]
                step([$class: 'CopyArtifact', filter: 'out/*.*', fingerprintArtifacts: true, flatten: true, projectName: 'PROS/atom', selector: [$class: 'ParameterizedBuildSelector', parameterName: 'ATOM_BUILD_SELECTOR']])
                step([$class: 'CopyArtifact', filter: 'out/*.*', fingerprintArtifacts: true, flatten: true, projectName: "${CLI_PROJECT_SELECTOR}", selector: [$class: 'ParameterizedBuildSelector', parameterName: 'CLI_BUILD_SELECTOR']])

                powershell '''Expand-Archive -Path .\\pros-editor-64-windows.zip -DestinationPath .\\pros-editor-64-windows
                              Expand-Archive -Path .\\pros-editor-windows.zip -DestinationPath .\\pros-editor-32-windows
                              Expand-Archive -Path .\\pros_cli-*-win-32bit.zip -DestinationPath .\\pros-cli-32-windows
                              Expand-Archive -Path .\\pros_cli-*-win-64bit.zip -DestinationPath .\\pros-cli-64-windows'''

                build_agent_ip = powershell returnStdout: true, script: '(Test-Connection -ComputerName (hostname) -Count 1).IPv4Address.IPAddressToString'
                emailext body: '''The build agent is on ${build_agent_ip}
Go to ${BUILD_URL} to approve.''', subject: 'Configure Digital Signature for Windows Installers (${BUILD_NUMBER})', to: 'edjubuh@gmail.com'
                input 'have fun'
                // try {
                //     timeout(time: 5, unit: 'HOURS') {
                //         input message: "Configure Digital Signature for Signing (${build_agent_ip})"
                //     }
                // } catch(org.jenkinsci.plugins.workflow.steps.FlowInterruptedException e) {
                //     cause = e.causes.get(0)
                //     echo "Aborted by " + cause.getUser().toString()
                //     if (cause.getUser().toString() != 'SYSTEM') {
                //         startMillis = System.currentTimeMillis()
                //     } else {
                //         endMillis = System.currentTimeMillis()
                //         if (endMillis - startMillis >= timeoutMillis) {
                //             echo "Approval timed out. Continuing with deployment."
                //         } else {
                //             echo "SYSTEM aborted, but looks like timeout period didn't complete. Aborting."
                //             currentBuild.result = 'ABORTED'     
                //         }
                //     }
                // } // end catch
            } // end node
        }
    )
}