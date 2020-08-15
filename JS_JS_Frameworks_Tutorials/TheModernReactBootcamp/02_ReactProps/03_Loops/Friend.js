class Friend extends React.Component {
    render() {
        const { name, hobbies } = this.props;

        return (
            <div>
                <h2>{name}</h2>
                <ul>
                    {hobbies.map((hobbie) => (
                        <li>{hobbie}</li>
                    ))}
                </ul>
            </div>
        );
    }
}
