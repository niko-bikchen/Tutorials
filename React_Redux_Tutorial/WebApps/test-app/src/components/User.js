import React from 'react'

const User = ({users}) => {
    const userList = users.length ? (
        users.map(user => {
            return (
                <div className="user card" key={user.id}>
                    <div className="card-content">
                        <span className="card-title blue-text">
                            {user.name} {user.surname}
                        </span>
                        <p>
                            {user.desc}
                        </p>
                    </div>
                </div>
            )
        })
    ) : (
            <div className="center">No users yet</div>
        )

    return (
        <div className="container users">
            {userList}
        </div>
    )
}

export default User
