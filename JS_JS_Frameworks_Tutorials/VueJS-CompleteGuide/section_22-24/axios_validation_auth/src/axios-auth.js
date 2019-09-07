import axios from 'axios';

// Creating axios instance
const instance = axios.create({
    // Configuration
    baseURL: "https://identitytoolkit.googleapis.com/v1/"
});

// instance.defaults.headers.common["SOMETHING"] = "Something";

export default instance;