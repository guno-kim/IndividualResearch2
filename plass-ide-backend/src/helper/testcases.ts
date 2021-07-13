import connection from "../connection";
import {getVariableTable} from './variables'

// function getTestCases(setting,cnt){
//     return new Promise(async(resolve,reject)=>{  
//         try{
//             let inputs=[]
//             let variableTable=await getVariableTable(setting.variables)

//             for(let i=0;i<cnt;i++){
//                 variableTable.init()
//                 let format=await getFormat(setting.inputBlocks,variableTable)
//                 let input=await getInput(format,variableTable)
//                 inputs.push(input)
//             }
//             resolve(inputs)
//         }catch(error){
//             console.log(error)
//             reject(error)
//         }
//     })
// }

export function getTestCases(problem:Object) {
    return new Promise(async (resolve,reject)=>{
        if(problem["auto"]){
            const variableTable=await getVariableTable(problem['id'])
            console.log(variableTable);
            
        }else{
            const [testCases] = await connection.execute("SELECT * FROM testCases WHERE problem = ?", [problem['id']]);
            resolve(testCases)
        }
    })
}

