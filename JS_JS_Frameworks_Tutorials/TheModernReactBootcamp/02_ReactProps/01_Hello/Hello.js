class Hello extends React.Component {
    render() {
        const bangs = '!'.repeat(this.props.bangs ? this.props.bangs : 1);

        return (
            <div>
                <p>
                    Hi {this.props.to} from {this.props.from}
                    {bangs}
                </p>
                <img src={this.props.img ? this.props.img : ''} />
            </div>
        );
    }
}
