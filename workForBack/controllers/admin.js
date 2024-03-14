const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Mes=require('../models/message');
const Admin=require("../models/admin")
const { promises } = require('dns');