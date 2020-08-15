class App extends React.Component {
    render() {
        const pics = ['🥞', '🥖', '🍕', '🥗'];

        return (
            <div>
                <SlotMachine slotPics={pics} />
                <br />
                <SlotMachine slotPics={pics} />
                <br />
                <SlotMachine slotPics={pics} />
            </div>
        );
    }
}

ReactDOM.render(<App />, document.getElementById('root'));
