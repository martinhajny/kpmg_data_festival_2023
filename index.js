const express = require('express');
const axios = require('axios');
const path = require('path');
require('dotenv').config()
const app = express();

// Send files from the public directory
app.use(express.static( path.resolve(__dirname, 'public') ));

// Handling JSON data 
app.use(express.json());       // to support JSON-encoded bodies
app.use(express.urlencoded({extended:true})); // to support URL-encoded bodies


app.get("/", (request, response) => {
    response.sendFile("index.html");
});

// our API

// POST - /api
app.post("/api", (req, res) => {
    console.log(req.body.question)
    axios.post(process.env.FUNCTIONAPP_URL + req.body.question)
      .then(function (response) {
        console.log(response.data);
        res.send(response.data);
      })
      .catch(function (error) {
        console.log(error);
      });
    
})

app.listen(3030, () => {
    console.log("check out the magic at: http://localhost:3030")
})