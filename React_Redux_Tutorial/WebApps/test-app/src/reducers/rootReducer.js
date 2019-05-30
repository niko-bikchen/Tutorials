import UserData from '../data/users.json'

const initState = {
    users: UserData.users
}

const rootReducer = (state = initState, action) => {
    return state;
}

export default rootReducer