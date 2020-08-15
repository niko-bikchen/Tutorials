class Hello extends React.Component {
    static defaultProps = {
        to: 'Anonymous',
        from: 'Anonymous',
        bangs: 1,
        img: ''
    };

    render() {
        const bangs = '!'.repeat(this.props.bangs);

        return (
            <div>
                <p>
                    Hi {this.props.to} from {this.props.from}
                    {bangs}
                </p>
                <img src={this.props.img} />
            </div>
        );
    }
}
