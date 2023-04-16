const baseJoi = require("joi");
const sanitizeHtml = require("sanitize-html");
const extension = (joi) => ({
    type: "string",
    base: joi.string(),
    messages: {
      "string.escapeHTML": "{{#label}} must not include HTML!",
    },
    rules: {
      escapeHTML: {
        validate(value, helpers) {
          const clean = sanitizeHtml(value, {
            allowedTags: [],
            allowedAttributes: {},
          });
          if (clean) {
            return clean;
        }
        return helpers.error("string.escapeHTML", { value });
        },
      },
    },
  });
const Joi = baseJoi.extend(extension);
module.exports.tournamentSchema = Joi.object({
    tournament: Joi.object({
        name: Joi.string().required().escapeHTML(),
        start_date: Joi.date().required(),
        end_date: Joi.date().required(),
    }).required(),
})

// TODO match schema
module.exports.matchSchema = Joi.object({
    review: Joi.object({
        body: Joi.string().required().escapeHTML(),
        rating: Joi.number().required().min(1).max(5)
    }).required()
});