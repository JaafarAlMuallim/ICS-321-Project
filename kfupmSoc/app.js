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

// const MongoStore = require("connect-mongo");

const helmet = require("helmet");

const app = express();

const User = null;

// const mongoSanitize = require("express-mongo-sanitize");

const tournaments = require("./routes/tournaments");
// const reviews = require("./routes/reviews");
const users = require("./routes/users");

const AppError = require("./utils/error");

// const dbUrl = process.env.DB_URL || 'mongodb://localhost:27017/yelpCamp';
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


app.use(session(config));
app.use(flash());

// const passport = require("passport");
// const localStrategy = require("passport-local");

app.engine("ejs", ejsMate);
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, 'public')))

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride("_method"));
app.use(helmet());

// const scriptSrcUrls = [
//     "https://stackpath.bootstrapcdn.com/",
//     "https://api.tiles.mapbox.com/",
//     "https://api.mapbox.com/",
//     "https://kit.fontawesome.com/",
//     "https://cdnjs.cloudflare.com/",
//     "https://cdn.jsdelivr.net",
// ];
// const styleSrcUrls = [
//     "https://kit-free.fontawesome.com/",
//     "https://stackpath.bootstrapcdn.com/",
//     "https://api.mapbox.com/",
//     "https://api.tiles.mapbox.com/",
//     "https://fonts.googleapis.com/",
//     "https://use.fontawesome.com/",
//     "https://cdn.jsdelivr.net",
// ];
// const connectSrcUrls = [
//     "https://api.mapbox.com/",
//     "https://a.tiles.mapbox.com/",
//     "https://b.tiles.mapbox.com/",
//     "https://events.mapbox.com/",
// ];
// const fontSrcUrls = [];
// app.use(
//     helmet.contentSecurityPolicy({
//         directives: {
//             defaultSrc: [],
//             connectSrc: ["'self'", ...connectSrcUrls],
//             scriptSrc: ["'unsafe-inline'", "'self'", ...scriptSrcUrls],
//             styleSrc: ["'self'", "'unsafe-inline'", ...styleSrcUrls],
//             workerSrc: ["'self'", "blob:"],
//             objectSrc: [],
//             imgSrc: [
//                 "'self'",
//                 "blob:",
//                 "data:",
//                 "https://res.cloudinary.com/dhwlc77xr/",
//                 "https://images.unsplash.com/",

//             ],
//             fontSrc: ["'self'", ...fontSrcUrls],
//         },
//     })
// );


// app.use(passport.initialize());
// app.use(passport.session());
// passport.use(new localStrategy(User.authenticate()));

// passport.serializeUser(User.serializeUser());
// passport.deserializeUser(User.deserializeUser());



app.use((req, res, next) => {
    res.locals.currentUser = req.user;
    res.locals.success = req.flash("success");
    res.locals.error = req.flash("error");
    next();
})


// deployment

// mongoose.connect(dbURL);
// const db = mongoose.connection;



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