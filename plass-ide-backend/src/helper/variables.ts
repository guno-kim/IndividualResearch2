import { arch } from "os";
import connection from "../connection";
import {VariableName} from '../types'

type Variable=IntVariable|CharVariable

class IntVariable{
    type:String
    name:VariableName;
    min:Number;
    max:Number;
    value:Number;
    fix:Boolean;
    // constructor(name,min,max,fix){
    //     this.type='int'
    //     this.name=name
    //     this.min=min
    //     this.max=max
    //     this.fix=fix
    //     this.value=undefined
    // }
    constructor(data){
        this.type='int'
        this.name=data.name
        this.min=data.min
        this.max=data.max
        this.fix=data.fix
        this.value=undefined
    }
    getData(){
        return{
            type:this.type,
            name:this.name,
            min:this.min,
            max:this.max,
            fix:this.fix,
            value:this.value,
        }
    }
}
class CharVariable{
    type:String
    name:VariableName;
    candidates:Array<VariableName>;
    fix:Boolean;
    value:String;
    // constructor(name,candidates,fix){
    //     this.type='char'
    //     this.name=name
    //     this.candidates=candidates
    //     this.fix=fix
    //     this.value=undefined
    // }
    constructor(data){
        this.type='char'
        this.name=data.name
        this.candidates=data.candidates
        this.fix=data.fix
        this.value=undefined
    }
    getData(){
        return{
            type:this.type,
            name:this.name,
            candidates:this.candidates,
            fix:this.fix,
            value:this.value,
        }
    }
}

class VariableTable{
    table:Array<Variable>
    constructor(variables){
        this.table=[]
        variables.forEach(v => {
            if(this.table.find( e =>  e.name==v.name))
                throw new Error('변수 이름 중복')
            this.table.push(v)
        });
        this.table.forEach(v=>{
            //v.value=undefined
            v.value=this.getValue1(v.name)
        })
    }
    
    getVariable(name){
        return this.table.find( e => e.name==name)
    }

    compute(line){// min, max 등 값이 변수계산 문자열일때 계산
        if (!isNaN(parseInt(line)))
            return eval(line)
        console.log('line to compute',line)
        for(let v of this.table){
            let re=new RegExp(v.name,'g')
            if(!line.includes(v.name))
                continue
            if(!v.value)
                throw new Error(`변수 선언 오류`)
            line=line.replace(re,v.value)
        }
        console.log('line after compute ',line)

        try {
            return eval(line)
        } catch (error) {
            throw new Error(`변수 선언 오류`)
        }
    }
    // getValue(name){
    //     if(!isNaN(parseFloat(name)))
    //         return eval(name)
    //     let v=this.getVariable(name)

    //     if(!v) throw new Error(`변수 선언 오류`)
    //     if(v.fix&&v.value!=undefined)
    //         return v.value
    //     let min=this.compute(v.min)
    //     let max=this.compute(v.max)
    //     if(isNaN(min)||isNaN(max)||min>max)
    //         throw new Error('최대 최소 오류')
    //     let value=Math.floor(Math.random() * (max - min + 1)) + min;
    //     v.value=value
    //     return value
    // }
    getValue1(name){
        let v=this.getVariable(name)
        if(!v) throw new Error(`선언하지 않은 변수 사용`)
        if(v.fix&&v.value!=undefined)
            return v.value
        if(v.type=='int'){
            v=new IntVariable(v.getData())
            let min=this.compute(v.min)
            let max=this.compute(v.max)
            if(isNaN(min)||isNaN(max)||min>max)
                throw new Error('최대 최소 오류')
            let value=Math.floor(Math.random() * (max - min + 1)) + min;
            v.value=value
            return value
        }
        else if(v.type=='char'){
            v=new CharVariable(v.getData())
            const candidates=v.candidates;
            let idx=Math.floor(Math.random() * (candidates.length));
            return candidates[idx]
        }
    }

    // init(variables){
    //     variables.forEach(v => {
    //         if(this.table.find( e =>  e.name==v.name))
    //             throw new Error('변수 이름 중복')
    //         this.table.push(v)
    //     });
    //     this.table.forEach(v=>{
    //         //v.value=undefined
    //         v.value=this.getValue(v.name)
    //     })
    // }
}

export const getVariableTable=(problems_id)=>{
    return new Promise( async (resolve,reject)=>{
        let [int_variables] = await connection.execute("SELECT * FROM int_variables WHERE problems_id = ?", [problems_id]);
        let [char_variables] = await connection.execute("SELECT * FROM char_variables WHERE problems_id = ?", [problems_id]);
        int_variables=int_variables.map((e)=>new IntVariable(e))
        char_variables=char_variables.map((e)=>new CharVariable({...e,candidates:e.candidates['data']}))
        console.log(int_variables.concat(char_variables));
        
        resolve( new VariableTable(int_variables.concat(char_variables)) )
    })
}   



