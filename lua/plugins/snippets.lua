-- lua/plugins/snippets.lua
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require "luasnip"
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local fmt = require("luasnip.extras.fmt").fmt

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- ================================================================
      -- MONGOOSE / MONGODB SNIPPETS
      -- ================================================================
      ls.add_snippets("javascript", {
        -- Mongoose Schema
        s("mschema", fmt([[
          const mongoose = require('mongoose');

          const {}Schema = new mongoose.Schema({{
            {}
          }}, {{
            timestamps: true
          }});

          module.exports = mongoose.model('{}', {}Schema);
        ]], {
          i(1, "User"),
          i(2, "name: { type: String, required: true }"),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1})
        })),

        -- Mongoose Model with Virtual
        s("mmodel", fmt([[
          const mongoose = require('mongoose');

          const {}Schema = new mongoose.Schema({{
            {}
          }}, {{ timestamps: true }});

          // Virtual
          {}Schema.virtual('{}').get(function() {{
            return {};
          }});

          module.exports = mongoose.model('{}', {}Schema);
        ]], {
          i(1, "User"),
          i(2, "firstName: String,\n  lastName: String"),
          f(function(args) return args[1][1] end, {1}),
          i(3, "fullName"),
          i(4, "this.firstName + ' ' + this.lastName"),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1})
        })),

        -- Mongoose Schema with Methods
        s("mmethod", fmt([[
          const mongoose = require('mongoose');
          const bcrypt = require('bcryptjs');

          const {}Schema = new mongoose.Schema({{
            {}
          }}, {{ timestamps: true }});

          // Instance method
          {}Schema.methods.{} = async function({}) {{
            {}
          }};

          // Static method
          {}Schema.statics.{} = async function({}) {{
            {}
          }};

          module.exports = mongoose.model('{}', {}Schema);
        ]], {
          i(1, "User"),
          i(2, "email: String,\n  password: String"),
          f(function(args) return args[1][1] end, {1}),
          i(3, "comparePassword"),
          i(4, "password"),
          i(5, "return await bcrypt.compare(password, this.password);"),
          f(function(args) return args[1][1] end, {1}),
          i(6, "findByEmail"),
          i(7, "email"),
          i(8, "return await this.findOne({ email });"),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1})
        })),

        -- Mongoose Pre Hook
        s("mpre", fmt([[
          {}Schema.pre('{}', async function(next) {{
            {}
            next();
          }});
        ]], {
          i(1, "User"),
          i(2, "save"),
          i(3, "// Pre-save logic")
        })),

        -- Mongoose Post Hook
        s("mpost", fmt([[
          {}Schema.post('{}', function(doc) {{
            {}
          }});
        ]], {
          i(1, "User"),
          i(2, "save"),
          i(3, "console.log('Document saved:', doc);")
        })),

        -- MongoDB Connection
        s("mconnect", fmt([[
          const mongoose = require('mongoose');

          const connectDB = async () => {{
            try {{
              const conn = await mongoose.connect(process.env.MONGO_URI, {{
                useNewUrlParser: true,
                useUnifiedTopology: true,
              }});
              console.log(`MongoDB Connected: ${{conn.connection.host}}`);
            }} catch (error) {{
              console.error(`Error: ${{error.message}}`);
              process.exit(1);
            }}
          }};

          module.exports = connectDB;
        ]], {})),

        -- Mongoose Populate
        s("mpop", fmt([[
          .populate({{
            path: '{}',
            select: '{}'
          }})
        ]], {
          i(1, "user"),
          i(2, "name email")
        })),

        -- Mongoose Aggregate
        s("magg", fmt([[
          const results = await {}.aggregate([
            {{ $match: {{ {} }} }},
            {{ $group: {{ _id: '${}', {} }} }},
            {{ $sort: {{ {} }} }}
          ]);
        ]], {
          i(1, "Model"),
          i(2, "status: 'active'"),
          i(3, "category"),
          i(4, "count: { $sum: 1 }"),
          i(5, "count: -1")
        })),

        -- ================================================================
        -- EXPRESS.JS SNIPPETS
        -- ================================================================
        -- Express Server
        s("exserver", fmt([[
          const express = require('express');
          const cors = require('cors');
          const dotenv = require('dotenv');
          const connectDB = require('./config/db');

          dotenv.config();
          connectDB();

          const app = express();

          // Middleware
          app.use(cors());
          app.use(express.json());
          app.use(express.urlencoded({{ extended: false }}));

          // Routes
          app.use('/api/{}', require('./routes/{}'));

          const PORT = process.env.PORT || 5000;
          app.listen(PORT, () => console.log(`Server running on port ${{PORT}}`));
        ]], {
          i(1, "users"),
          i(2, "users")
        })),

        -- Express Route
        s("exroute", fmt([[
          const express = require('express');
          const router = express.Router();
          const {{ {} }} = require('../controllers/{}');

          router.get('/', {});
          router.get('/:id', {});
          router.post('/', {});
          router.put('/:id', {});
          router.delete('/:id', {});

          module.exports = router;
        ]], {
          i(1, "getItems, getItem, createItem, updateItem, deleteItem"),
          i(2, "itemController"),
          i(3, "getItems"),
          i(4, "getItem"),
          i(5, "createItem"),
          i(6, "updateItem"),
          i(7, "deleteItem")
        })),

        -- Express Controller
        s("exctrl", fmt([[
          const {} = require('../models/{}');

          // @desc    Get all {}
          // @route   GET /api/{}
          // @access  Public
          const get{}s = async (req, res) => {{
            try {{
              const {}s = await {}.find();
              res.json({}s);
            }} catch (error) {{
              res.status(500).json({{ message: error.message }});
            }}
          }};

          // @desc    Get single {}
          // @route   GET /api/{}/:id
          // @access  Public
          const get{} = async (req, res) => {{
            try {{
              const {} = await {}.findById(req.params.id);
              if (!{}) {{
                return res.status(404).json({{ message: '{} not found' }});
              }}
              res.json({});
            }} catch (error) {{
              res.status(500).json({{ message: error.message }});
            }}
          }};

          // @desc    Create {}
          // @route   POST /api/{}
          // @access  Private
          const create{} = async (req, res) => {{
            try {{
              const {} = await {}.create(req.body);
              res.status(201).json({});
            }} catch (error) {{
              res.status(400).json({{ message: error.message }});
            }}
          }};

          module.exports = {{ get{}s, get{}, create{} }};
        ]], {
          i(1, "Item"),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() .. "s" end, {1}),
          f(function(args) return args[1][1]:lower() .. "s" end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1]:lower() .. "s" end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1]:lower() .. "s" end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1]:lower() end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1})
        })),

        -- Express Middleware
        s("exmid", fmt([[
          const {} = (req, res, next) => {{
            {}
            next();
          }};

          module.exports = {};
        ]], {
          i(1, "middleware"),
          i(2, "// Middleware logic"),
          f(function(args) return args[1][1] end, {1})
        })),

        -- Express Error Handler
        s("exerr", fmt([[
          const errorHandler = (err, req, res, next) => {{
            const statusCode = res.statusCode === 200 ? 500 : res.statusCode;
            res.status(statusCode);
            res.json({{
              message: err.message,
              stack: process.env.NODE_ENV === 'production' ? null : err.stack
            }});
          }};

          module.exports = errorHandler;
        ]], {})),

        -- JWT Auth Middleware
        s("jwtauth", fmt([[
          const jwt = require('jsonwebtoken');
          const User = require('../models/User');

          const protect = async (req, res, next) => {{
            let token;

            if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {{
              try {{
                token = req.headers.authorization.split(' ')[1];
                const decoded = jwt.verify(token, process.env.JWT_SECRET);
                req.user = await User.findById(decoded.id).select('-password');
                next();
              }} catch (error) {{
                res.status(401).json({{ message: 'Not authorized, token failed' }});
              }}
            }}

            if (!token) {{
              res.status(401).json({{ message: 'Not authorized, no token' }});
            }}
          }};

          module.exports = {{ protect }};
        ]], {})),

        -- ================================================================
        -- REACT SNIPPETS
        -- ================================================================
        -- React Functional Component
        s("rfc", fmt([[
          import React from 'react';

          const {} = () => {{
            return (
              <div>
                {}
              </div>
            );
          }};

          export default {};
        ]], {
          i(1, "Component"),
          i(2, "<h1>Component</h1>"),
          f(function(args) return args[1][1] end, {1})
        })),

        -- React useState Hook
        s("ust", fmt([[
          const [{}, set{}] = useState({});
        ]], {
          i(1, "state"),
          f(function(args) return args[1][1]:sub(1,1):upper() .. args[1][1]:sub(2) end, {1}),
          i(2, "''")
        })),

        -- React useEffect Hook
        s("uef", fmt([[
          useEffect(() => {{
            {}
          }}, [{}]);
        ]], {
          i(1, "// Effect logic"),
          i(2, "")
        })),

        -- Fetch API Call
        s("fetch", fmt([[
          const {}Data = async () => {{
            try {{
              const response = await fetch('{}');
              const data = await response.json();
              {}
            }} catch (error) {{
              console.error('Error:', error);
            }}
          }};
        ]], {
          i(1, "fetch"),
          i(2, "http://localhost:5000/api/items"),
          i(3, "setData(data);")
        })),

        -- Axios GET Request
        s("axget", fmt([[
          const {}Data = async () => {{
            try {{
              const {{ data }} = await axios.get('{}');
              {}
            }} catch (error) {{
              console.error('Error:', error.response?.data?.message || error.message);
            }}
          }};
        ]], {
          i(1, "fetch"),
          i(2, "/api/items"),
          i(3, "setData(data);")
        })),

        -- Axios POST Request
        s("axpost", fmt([[
          const {}Data = async ({}) => {{
            try {{
              const {{ data }} = await axios.post('{}', {});
              {}
            }} catch (error) {{
              console.error('Error:', error.response?.data?.message || error.message);
            }}
          }};
        ]], {
          i(1, "create"),
          i(2, "formData"),
          i(3, "/api/items"),
          i(4, "formData"),
          i(5, "console.log(data);")
        })),

        -- React Context
        s("rctx", fmt([[
          import {{ createContext, useContext, useState }} from 'react';

          const {}Context = createContext();

          export const use{} = () => {{
            const context = useContext({}Context);
            if (!context) {{
              throw new Error('use{} must be used within {}Provider');
            }}
            return context;
          }};

          export const {}Provider = ({{ children }}) => {{
            const [{}, set{}] = useState({});

            return (
              <{}Context.Provider value={{ {{ {}, set{} }} }}>
                {{children}}
              </{}Context.Provider>
            );
          }};
        ]], {
          i(1, "Auth"),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {1}),
          i(2, "user"),
          f(function(args) return args[1][1]:sub(1,1):upper() .. args[1][1]:sub(2) end, {2}),
          i(3, "null"),
          f(function(args) return args[1][1] end, {1}),
          f(function(args) return args[1][1] end, {2}),
          f(function(args) return "set" .. args[1][1]:sub(1,1):upper() .. args[1][1]:sub(2) end, {2}),
          f(function(args) return args[1][1] end, {1})
        }))
      })

      -- TypeScript/TSX snippets (same as JS but with types)
      ls.add_snippets("typescript", ls.get_snippets("javascript"))
      ls.add_snippets("typescriptreact", ls.get_snippets("javascript"))
    end
  }
}
