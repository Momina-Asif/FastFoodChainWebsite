
// const mysql = require('mysql');
// const bodyParser = require('body-parser');
// const db = require("./database");
// const path = require('path');
// const app = express();
// const port = 5000;
// const hostname = '127.0.0.1'
// const fs = require('fs');

// const http = require('http');
// const signup = fs.readFileSync('signup.html')
// app.use(express.static(__dirname + '/public'));
// // Middleware to parse JSON and URL-encoded bodies

//  const server = http.createServer((req, res) => {

//      console.log(req.url);
//      res.statusCode = 200;
//      res.setHeader('Content-Type', 'text/html');
//     // res.end(signup);
//      res.end(home);
//  });


// // Start the server
// server.listen(port, hostname, () => {
//   console.log(`Server running at http://localhost:${port}`);
// });
const cors = require('cors');
const db = require("./database");
//const session = require('express-session'); 

const port = 5000;
const hostname = '127.0.0.1';

const express = require('express');
const session = require('express-session');
const app = express();
const bodyParser = require('body-parser');
app.use(cors({ origin: '*' }));


app.use(session({
    secret: '123', 
    resave: false,
    saveUninitialized: true
}));


app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.static('public'));

//Route for serving the signup page
app.get('/update-order-status', (req, res) => {
    res.sendFile(__dirname + '/update-order-status');
});

app.get('/signup', (req, res) => {
    res.sendFile(__dirname + '/signup.html');
});


app.get('/mobile.css', (req, res) => {
    res.sendFile(__dirname + '/mobile.css');
});

app.get('/home', (req, res) => {
    res.sendFile(__dirname + '/home.html');
});

app.get('/login', (req, res) => {
    res.sendFile(__dirname + '/login.html');
});


app.get('/menu.html', (req, res) => {
    res.sendFile(__dirname + '/menu.html');
});

app.get('/YourCart.html', (req, res) => {
    res.sendFile(__dirname + '/YourCart.html');
});

app.get('/apply-promo', (req, res) => {
    res.sendFile(__dirname + '/apply-promo');
});

app.get('/jason-leung-poI7DelFiVA-unsplash.jpg', (req, res) => {
    res.sendFile(__dirname + '/jason-leung-poI7DelFiVA-unsplash.jpg');
});

app.get('/error', (req, res) => {
    res.sendFile(__dirname + '/error.html');
});

app.get('/style.css', (req, res) => {
    res.sendFile(__dirname + '/style.css');
});

app.get("/menu", (req, res) => {
    db.query(`SELECT * FROM Menu`, (err, result, fields) => {
      if (err) {
        console.error("Error fetching data from database:", err);
        res.status(500).json({ error: "An error occurred while fetching data from the database" });
      } else {
        //res.status(200).json(result);
            res.status(200).json(result);
      }
    });
  });

 


  app.get('/update-order-status' , (req, res) => {
    res.sendFile(__dirname + '  /update-order-status');
});

app.get('/add-to-cart' , (req, res) => {
    res.sendFile(__dirname + '/add-to-cart');
});
app.get('/delete-item' , (req, res) => {
    res.sendFile(__dirname + '/delete-item');
});
  var errMessage = '';

app.post('/signup', (req, res) => {
    
    const { username, email, contact, password } = req.body;

    db.query(
        'CALL InsertCustomerInfo(?, ?, ?, ?)',
        [username, email, password, contact],
        (err, result) => {
            if(err){
                
                const errorMessage = encodeURIComponent(err.sqlMessage);
               
                return res.redirect('/signup?error=' + errorMessage);
        }
        else {
                // Logging user data
                console.log('New user signed up:');
                console.log('Username:', username);
                console.log('Email:', email);
                console.log('Contact:', contact);
                console.log('Password:', password);

                // Redirecting the user to the homepage after successful signup
               res.redirect('/home');
            }
        }
    );
});



app.use(bodyParser.json());


app.post('/add-to-cart', (req, res) => {
    
    const email1 = req.session.email;
    if (!email1) {
        return res.status(401).json({ error: 'User not logged in' });
    }

    const itemId = req.body.itemId;
    db.query('Call AddItemToOrder2(?, ?)', [email1, itemId], (err, result) => {  if(err){
        const errorMessage = encodeURIComponent(err.sqlMessage);

}
else{
    res.status(200).json(result);

}});
//     res.sendStatus(200); // Send success response
});
app.get('/get-user-orders', (req, res) => {
    const email1 = req.session.email;
    
    db.query('Call GetUserOrders2(?)', [email1], (err, result) => {  
        if(err){
        const errorMessage = encodeURIComponent(err.sqlMessage);
        }
        else {
            res.status(200).json(result);
        }
});
//     res.sendStatus(200); // Send success response
});



app.post('/login', (req, res) => {
    const {email, password } = req.body;
    db.query(
        'CALL AuthenticateUser(?, ?)',
        [email, password],
        (err, result) => {
            if(err){
                const errorMessage = encodeURIComponent(err.sqlMessage);
                    return res.redirect('/login?error=' + errorMessage);

        }
        else {
                // Logging user data
                console.log('New user logged in:');
                console.log('Email:', email);
                console.log('Password:', password);
                email1 = email;
                req.session.email = email;
               res.redirect('/home');
            }
        }
    );
});


app.post('/update-order-status', (req, res) => {
    const {status } = req.body;
    db.query(
        'CALL UpdateOrderStatusByEmail(?);',
        [email1],
        (err, result) => {
            if(err){
                const errorMessage = encodeURIComponent(err.sqlMessage);
                    return res.redirect(errorMessage);

        }
        else{
            res.redirect(result)
        }
        }
    );
});



app.post('/delete-item', (req, res) => {
    const {itemName, stat } = req.body;
    console.log(itemName);
    console.log(stat);
    db.query('call UpdateItemStatus1(?, ?, ?);',[itemName, email1, stat],
        
        (err, result) => {
            if(err){
                const errorMessage = encodeURIComponent(err.sqlMessage);
                console.log(errorMessage);
                    // Redirect back to the signup page with error message
                    return res.redirect(errorMessage);
                    

        }
        else{
            res.redirect(result)
        }
        }
    );

});


app.get('/check-login', (req, res) => {
    const loggedIn = !!req.session.email; // Check if the email is set in the session
    res.json({ loggedIn }); // Send response indicating login status
});


app.get('/logout', (req, res) => {
    // Destroy the session
    req.session.destroy((err) => {
        if (err) {
            console.error('Error destroying session:', err);
            res.status(500).json({ error: 'An error occurred while logging out' });
        } else {
            // Redirect the user to the login page after successful logout
            res.redirect('/home');
        }
    });
});
app.post('/apply-promo', (req, res) => {
    const { promoCode } = req.body;

    // Call the stored procedure to check the promo code and get the promo amount
    db.query('CALL CheckPromoCode(?);', [promoCode], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        // Check if the result contains data or an error message
        if (result && result[0] && result[0][0] && result[0][0].Discount) {
            const promoAmount = result[0][0].Discount;
            res.status(200).json({ promoAmount });
        } else {
            res.status(400).json({ error: 'Promo code does not exist' });
        }
    });
});


// Start the server\
app.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/home`);
  });
  
  