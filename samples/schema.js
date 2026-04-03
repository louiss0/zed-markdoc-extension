module.exports = {
  tags: {
    "moon-phase": {
      render: "MoonPhase",
      description: "A dramatic block tag for nocturnal product or science notes.",
      attributes: {
        phase: {
          type: String,
          required: true,
          matches: ["new", "waxing", "full", "waning"],
        },
        audience: {
          type: String,
        },
      },
    },
    "spice-radar": {
      render: "SpiceRadar",
      description: "A self-closing tag for strange food telemetry.",
      selfClosing: true,
      attributes: {
        heat: {
          type: String,
          required: true,
          matches: ["low", "medium", "high", "nebula"],
        },
        signal: {
          type: String,
          required: true,
        },
      },
    },
    "glitch-garden": {
      render: "GlitchGarden",
      description: "A block tag for soft-chaos interface experiments.",
      attributes: {
        mode: {
          type: String,
          required: true,
          matches: ["soft-chaos", "clean-chaos", "loud-chaos"],
        },
        season: {
          type: String,
        },
      },
    },
    "time-pickle": {
      render: "TimePickle",
      description: "A self-closing tag for preserved future observations.",
      selfClosing: true,
      attributes: {
        year: {
          type: Number,
          required: true,
        },
        jar: {
          type: String,
          matches: ["glass", "ceramic", "steel"],
        },
        acidity: {
          type: Number,
        },
      },
    },
    "orbit-menu": {
      description: "A block tag for menus designed under unusual constraints.",
      attributes: {
        course: {
          type: String,
          required: true,
          matches: ["starter", "main", "dessert"],
        },
        gravity: {
          type: String,
          matches: ["low", "standard", "heavy"],
        },
      },
    },
  },
};
