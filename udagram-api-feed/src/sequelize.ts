import {Sequelize} from 'sequelize-typescript';
import {config} from './config/config';
import { SequelizeConfig } from 'sequelize-typescript/lib/types/SequelizeConfig';

let sequelizeConfig: SequelizeConfig = {
  'username': config.username,
  'password': config.password,
  'database': config.database,
  'host': config.host,
  'dialect': config.dialect,
  'storage': ':memory:',
};


if(process.env.NODE_ENV === "local") {
  sequelizeConfig = {
    ...sequelizeConfig,
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false,
      }
    },
  };
}

export const sequelize = new Sequelize(sequelizeConfig);