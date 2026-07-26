import { Router } from 'express';
import { getAppSettings } from './config.controller.js';

export const configRoutes = Router();

configRoutes.get('/app-settings', getAppSettings);
