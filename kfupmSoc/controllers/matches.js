// const Campground = require("../models/campground");
// const mbxGeocoding = require("@mapbox/mapbox-sdk/services/geocoding")
// const mapboxToken = process.env.MAPBOX_TOKEN;
// const geocoder = mbxGeocoding({ accessToken: mapboxToken });
// const { cloudinary } = require("../cloudinary");

module.exports.index = async (req, res) => {
    // const tournaments = await Tournament.find();
    const tournaments = null
    res.render("matches/index", { tournaments })
}

module.exports.new = (req, res) => {
    res.render("tournaments/new")
}

module.exports.createTournament = async (req, res, next) => {
    // const geoData = await geocoder.forwardGeocode({
    //     query: req.body.campground.location,
    //     limit: 1
    // }).send();
    // const camp = new Campground(req.body.campground);
    // camp.geometry = geoData.body.features[0].geometry;
    // camp.images = req.files.map(file => ({ url: file.path, filename: file.filename }));
    // camp.author = req.session.user._id;
    // await camp.save();
    // req.flash("success", "Successfully Added The Camp");
    // res.redirect(`campgrounds/${camp._id}`);
}
// TODO FINISH IT
module.exports.showTournament = async (req, res, next) => {

    // const match = await 
    // const camp = await Campground.findById(req.params.id).populate({
    //     path: "reviews",
    //     populate: "author",
    // }).populate("author");
    // if (!camp) {
    //     req.flash("error", "Cannot Find That Campground");
    //     return res.redirect("/campgrounds")
    // }
    // res.render("campgrounds/show", { camp })
}

module.exports.deleteTournament = async (req, res, next) => {
    // const deleted = await Campground.findByIdAndDelete(req.params.id);
    // req.flash("success", "Successfully Deleted The Camp");
    // res.redirect("/campgrounds");
}
module.exports.editTournament = async (req, res, next) => {
    // const camp = await Campground.findById(req.params.id);

    // if (!camp) {
    //     req.flash("error", "Cannot Find That Campground");
    //     return res.redirect("/campgrounds")
    // }
    // res.render("campgrounds/edit", { camp })
}
module.exports.updateTournament = async (req, res, next) => {
    // if (!req.body.campground) throw new AppError("Invalid Data", 400);
    // const { id } = req.params;
    // console.log(req.body);
    // const camp = await Campground.findByIdAndUpdate(id, req.body.campground, { runValidators: true });
    // const imgs = req.files.map(file => ({ url: file.path, filename: file.filename }));
    // camp.images.push(...imgs);
    // await camp.save();

    // if (req.body.deleteImages.length) {
    //     for (let filename of req.body.deleteImages) {
    //         await cloudinary.uploader.destroy(filename);
    //     }
    //     await camp.updateOne({ $pull: { images: { filename: { $in: req.body.deleteImages } } } });
    // }
    // req.flash("success", "Successfully Updated The Camp");
    // res.redirect(`/campgrounds/${id}`);
}