import connection from "../connection";
import {getVariableTable} from './variables'

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

        //box 변수 대입, string화
        let input=""
        for(let i=0;i<blocks.length;i++){
            let box=blocks[i].box
            

            for(let j=0;j<box.length;j++){
                let row=box[j]
                
                for(let k=0;k<row.length;k++){
                    row[k]=variableTable.getValue(row[k])
                }

            }


        }
        console.log(blocks[0].box);
        console.log(blocks[1].box);

        resolve(1)
    })

}


export const getTestCases=(problem:Object)=>{
    return new Promise(async (resolve,reject)=>{
        if(problem["auto"]){
            const variableTable=await getVariableTable(problem['id'])
            const blocks=await getBlocks(problem['id'],variableTable)
            console.log('-----------------');
            
        }else{
            const [testCases] = await connection.execute("SELECT * FROM testCases WHERE problem = ?", [problem['id']]);
            resolve(testCases)
        }
    })
}

