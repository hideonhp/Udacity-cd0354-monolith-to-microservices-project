import {Sequelize} from 'sequelize-typescript';
import {config} from './config/config';
import { SequelizeConfig } from 'sequelize-typescript/lib/types/SequelizeConfig';

const sequelizeConfig: SequelizeConfig = {
  'username': config.username,
  'password': config.password,
  'database': config.database,
  'host': config.host,
  'dialectOptions': {
    'ssl': {
      'require': true,
      'rejectUnauthorized': false,
    },
  },
  'dialect': config.dialect,
  'storage': ':memory:',
};


export const sequelize = new Sequelize(sequelizeConfig);