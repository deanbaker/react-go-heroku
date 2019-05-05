
import React, { Component } from 'react'
import axios from 'axios';
class PingComponent extends Component {

    constructor() {
        super();
        this.state = {
            pong: 'pending'
        }
    }

    componentWillMount() {
        axios.get('api/ping')
            .then((response) => {
                this.setState(() => {
                    return { pong: response.data.message }
                })
            })
            .catch(function (error) {
                console.log(error);
            });

    }

    render() {
        return <h1>Ping {this.state.pong}</h1>;
    }
}

export default PingComponent; 