export interface IUser {
    name: string;
    pw: string;
}

export interface IProblem {
    number: string;
    type: string;
    question: string;
    answer: string;
}

export interface IFile {
    name: string;
    isDirectory: boolean;
    path: string;
    ext?: string;
    size?: number;
    files?: Array<IFile>;
    data?: any;
}

export type VariableName='a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' 
| 'l' | 'm' | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' 
| 'y' | 'z'