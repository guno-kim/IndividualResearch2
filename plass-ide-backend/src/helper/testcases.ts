import connection from "../connection";
import {getVariableTable} from './variables'
import {getAnswerPath} from './path-helper'
import {test} from './test'
const getBlocks=(problems_id,variableTable)=>{
    return new Promise(async (resolve, reject) => {
        let [blocks] = await connection.execute("SELECT * FROM blocks WHERE problems_id = ?", [problems_id]);
        
        //box에 반복횟수 적용
        blocks=blocks.map((block)=>{
            let {box,vertical_rep,horizon_rep,space}=block
            box=box.data
            vertical_rep=variableTable.getValue(vertical_rep)
            horizon_rep=variableTable.getValue(horizon_rep)
            if(isNaN(vertical_rep) || isNaN(horizon_rep) || vertical_rep<=0 || horizon_rep<=0)
                throw new Error('반복횟수 오류')
            
            box=box.map(element => {
                let temp=[]
                for(let i=0;i<horizon_rep;i++){
                    temp=temp.concat(element)
                } 
                return temp   
            });

            let temp=box.map((row)=>row.slice())
            for(let i=0;i<vertical_rep-1;i++){
                let temp1=temp.map((row)=>row.slice())
                box=box.concat(temp1)
            }
            return {box,space}
        })
       resolve(blocks)
    })
}

const getInput=(blocks,variableTable)=>{
    return new Promise((resolve, reject) => {
        //box 변수 대입
        for(let i=0;i<blocks.length;i++){
            let box=blocks[i].box
            for(let j=0;j<box.length;j++){
                let row=box[j]
                for(let k=0;k<row.length;k++){
                    row[k]=variableTable.getValue(row[k])
                }
            }
        }
        //블록 string화해 input 생성
        let input=""
        for(let i=0;i<blocks.length;i++){
            let {box,space}=blocks[i]
            for(let j=0;j<box.length;j++){
                let row=box[j]
                if(space)
                    input+=row.join(" ")+'\n'
                else
                    input+=row.join("")+'\n'
            }
        }
        resolve(input)
    })
    
}
const getInputs=(problem,variableTable,testCaseNum)=>{
    return new Promise(async(resolve, reject) => {
        let inputs=[]
        for (let i = 0; i < testCaseNum; i++) {
            const blocks=await getBlocks(problem['id'],variableTable)
            const input=await getInput(blocks,variableTable)
            inputs.push(input)
        }
        resolve(inputs)
    })
}

const getOutput= (problemId,inputs)=>{
    return new Promise(async(resolve, reject) => {
        const path=getAnswerPath(String(problemId))
        const outputs=await test(path,'java',inputs)
        resolve(outputs)
    })
}

export const getTestCases=(problem:Object)=>{
    return new Promise(async (resolve,reject)=>{
        if(problem["auto"]){
            const variableTable=await getVariableTable(problem['id'])
            const inputs=await getInputs(problem,variableTable,10)
            let outputs:any=await getOutput(problem['id'],inputs)
            outputs=outputs.map((e)=>{
                if(e.compile)
                    return e.output
            })
            
            resolve({inputs,outputs})
        }else{
            const [row] = await connection.execute("SELECT * FROM testCases WHERE problem = ?", [problem['id']]);
            let inputs=row.map((e)=>e.input)
            let outputs=row.map((e)=>e.output)
            resolve({inputs,outputs})
        }
    })
}

