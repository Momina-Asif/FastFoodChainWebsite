const {createPool} = require('mysql');

const pool = createPool({
    host:"localhost",
    user:"root",
    password: "",
    database: "restaurant",
    connectionLimit: 21000
})
module.exports = pool;

