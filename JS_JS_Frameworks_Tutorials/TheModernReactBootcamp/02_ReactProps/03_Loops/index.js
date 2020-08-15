class App extends React.Component {
    render() {
        return (
            <div>
                <Friend name="Mike" hobbies={['Singing', 'Dancing']}/>
            </div>
        );
    }
}

ReactDOM.render(<App />, document.getElementById('root'));
