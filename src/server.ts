import express from 'express'
import router from './router';
import morgan from 'morgan'
import cors from 'cors'
import { protect } from './modules/auth';
import { createNewUser, signin } from "./handlers/users";


const app = express();
 app.use(morgan('dev'))
 app.use(express.json())
 app.use(express.urlencoded({extended: true}))
 app.use(cors())

// app.get('/', (req, res)=>{
//     console.log('heloo from express')
//     res.status(200)
//     res.json({message: 'hello from server'})
// })
app.get('/', (req, res, next)=>{
    res.json({message: "Hello"})
})
app.use('/api', protect, router)
app.post("/user", createNewUser);
app.post("/signin", signin);


export default app;