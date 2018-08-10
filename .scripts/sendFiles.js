const fs = require('fs')
const fetch = require('node-fetch')

let obj = {
    link:'',
    response:{
        eslintMessage:'',
        eslintFail:'',
        unitTestMessage:'',
        unitTestFail:'',
    }
}

let fs1 = new Promise ((resolve) => {fs.readFile('./tmp/gitPath.txt', 'utf-8', function read(err, data) {
    if (err) {
        throw err;
    }
    resolve(data);
})});

let fs2 = new Promise ((resolve) => {fs.readFile('./tmp/eslintMessage.json', 'utf-8', function read(err, data) {
    if (err) {
        throw err;
    }
    resolve(data);
})});

let fs3 = new Promise ((resolve) => {fs.readFile('./tmp/eslintFail.txt', 'utf-8', function read(err, data) {
    if (err) {
        throw err;
    }
    resolve(data);
})});

let fs4 = new Promise ((resolve) => {fs.readFile('./tmp/unitTestMessage.json', 'utf-8', function read(err, data) {
    if (err) {
        throw err;
    }
    resolve(data);
})});

let fs5 = new Promise ((resolve) => {fs.readFile('./tmp/unitTestFail.txt', 'utf-8', function read(err, data) {
    if (err) {
        throw err;
    }
    resolve(data);
})});

const sendFilesToDB = (obj) => {
    console.log(obj.response.eslintMessage)
    // console.log(JSON.stringify(obj.response.eslintMessage));
    fetch ('https://us-central1-github-hook-fe560.cloudfunctions.net/api2', {
        method: 'POST',
        body: JSON.stringify(obj)
    })
}

fs1.then((data) => {
    obj.link=data;
    fs2.then((data) => {
        obj.response.eslintMessage=JSON.parse(data);
        fs3.then((data) => {
            obj.response.eslintFail=data;
            fs4.then((data) => {
                obj.response.unitTestMessage=JSON.parse(data);
                fs5.then((data) => {
                    obj.response.unitTestFail=data;
                    sendFilesToDB(obj);
                })
            })
        })
    })
})

