//--------- -----STRINGS-------------------

const baseUrl = 'localhost:8000/api/';

// user
const userRegisterUrl = '${baseUrl}users/register';
const userLoginUrl = '${baseUrl}users/login';
const userInfoUrl = '${baseUrl}users/';

// expert
const expertRegisterUrl = '${baseUrl}experts/register';
const expertLoginUrl = '${baseUrl}experts/login';
const expertInfoUrl = '${baseUrl}experts/';
const expertsOfConsultation = '${baseUrl}experts/searchByConsultation/';

// --------------Errors-----------

const serverError = 'server error !';
const someThingWentWront = 'sorry, something went wront !';
const unauthorized = 'unauthorized !';
