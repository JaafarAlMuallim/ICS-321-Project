if (process.env.NODE_ENV !== "production") {
    require("dotenv").config();
}
const express = require("express");
const path = require("path");
const bodyParser = require('body-parser');
const methodOverride = require("method-override");
const ejsMate = require("ejs-mate");
const flash = require("connect-flash");
const session = require("express-session");
const helmet = require("helmet");
const app = express();
const tournaments = require("./routes/tournaments");
const users = require("./routes/users");
const AppError = require("./utils/error");
const secret = process.env.SECRET || "thisshouldbebettersecreet";

const config = {
    secret,
    resave: false,
    saveUninitialized: true,
    cookie: {
        httpOnly: true,
        expires: Date.now() + (1000 * 60 * 60 * 24 * 7),
        maxAge: (1000 * 60 * 60 * 24 * 7)
    }
}
var currentUser;
app.use(session(config));
app.use(flash());


app.use((req, res, next) => {
    res.locals.session = req.session;
    res.locals.currentUser = req.session.currentUser;
    res.locals.success = req.flash("success");
    res.locals.error = req.flash("error");
    next();
})



app.engine("ejs", ejsMate);
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, 'public')))

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride("_method"));
app.use(helmet());

const scriptSrcUrls = [
    "https://stackpath.bootstrapcdn.com/",
    "https://kit.fontawesome.com/",
    "https://cdnjs.cloudflare.com/",
    "https://cdn.jsdelivr.net",
    "https://www.gstatic.com/",
    "https://www.google.com/",
    "https://identitytoolkit.googleapis.com/",
];
const styleSrcUrls = [
    "https://kit-free.fontawesome.com/",
    "https://stackpath.bootstrapcdn.com/",
    "https://fonts.googleapis.com/",
    "https://use.fontawesome.com/",
    "https://cdn.jsdelivr.net",
    "https://www.google.com/",
    "https://identitytoolkit.googleapis.com/"
    
];
const connectSrcUrls = [
    "https://www.google.com/",
    'https://identitytoolkit.googleapis.com/',
    'https://securetoken.googleapis.com/'
];
const fontSrcUrls = [];
const frameSrcUrls = [
    "https://www.google.com/",
]
app.use(
    helmet.contentSecurityPolicy({
        directives: {
            defaultSrc: [],
            connectSrc: ["'self'", ...connectSrcUrls],
            scriptSrc: ["'unsafe-inline'", "'self'", ...scriptSrcUrls],
            styleSrc: ["'self'", "'unsafe-inline'", ...styleSrcUrls],
            workerSrc: ["'self'", "blob:"],
            objectSrc: [],
            imgSrc: [
                "'self'",
                "blob:",
                "data:",
                "https://res.cloudinary.com/dhwlc77xr/",
                "https://images.unsplash.com/",

            ],
            fontSrc: ["'self'", ...fontSrcUrls],
            frameSrc: [...frameSrcUrls]
        },
    })
);


const { getAuth, onAuthStateChanged } = require("firebase/auth");

const auth = getAuth();
onAuthStateChanged(auth, (user) => {
  if (user) {
    const uid = user.uid;
    console.log(uid);
    currentUser = auth.currentUser;
  } else {
    console.log('OUT');
  }
});

app.use("/", users);
app.use("/tournaments", tournaments);
app.use("/tournaments/:id", tournaments);
// app.use("/tournaments/matches", matches)
// app.use("/tournaments/matches/:id/info", match_info)
// app.use("/campgrounds/:id/reviews", reviews);
// app.use("/campgrounds/:id/reviews", reviews);

app.get("/", (req, res) => {
    res.render("home");
})


app.all("*", (req, res, next) => {

    next(new AppError("Page Not Found", 404));
    // res.send("404!!!!!!");
})
app.use((err, req, res, next) => {
    const { statusCode = 500 } = err;

    if (!err.message) err.message = "Something Went Wrong!!";
    res.status(statusCode).render("error", { err });
})

const port = 3000;

app.listen(port, () => {
    console.log(`LISTENING ON PORT ${port}`);
})