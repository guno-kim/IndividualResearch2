import {ChildProcess, spawn} from "child_process";


export const test=(sourcePath,language,inputs)=>{
    return new Promise((resolve, reject) => {
        let docker: ChildProcess;
        switch(language) {
            case "java":
                docker = spawn("docker", ["run", "--rm", "-i", "-v", `${sourcePath}:/src`, "java-build:1.0"]);
                break;
            case "c":
                docker = spawn("docker", ["run", "--rm", "-i", "-v", `${sourcePath}:/src`, "c-build:1.0"]);
                break;
        }

        let isDockerDie = false;
        docker.stderr.on("data", (data) => {
            console.log(data.toString());
            if(isDockerDie) return;
            isDockerDie = true;
            reject({
                compile: false,
                testMax: 0, // 테스트 케이스 개수
                testSuccess: 0
            });
        })

        docker.stdout.on("end", async (data) => {
            if(isDockerDie) return;
            const testMax = inputs.length;
            let testProccessing = 0;
            let testResult=[]
            for(let i=0;i<testMax;i++){
                testResult.push({output:"",compile:false})
            }
            
            
            inputs.forEach((input,i) => {
                const runTestCaseProcess = spawn("docker", ["run", "--rm", "-i", "-v", `${sourcePath}:/src`, "java-run:1.0"]);

                runTestCaseProcess.stdin.write(input + "\n");

                runTestCaseProcess.stdout.on("data", (value) => {; 
                    value=value.toString().trim();
                    testResult[i].output=value
                });

                runTestCaseProcess.on("close", function() {
                    testResult[i].compile=true
                    testProccessing++;
                    if(testMax <= testProccessing) {
                        resolve(testResult);
                    }
                });
            });
        })
    })
}