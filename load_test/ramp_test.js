import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
    stages: [
        { duration: '5m', target: 100 },
        { duration: '5m', target: 100 },
        { duration: '5m', target: 200 },
        { duration: '5m', target: 200 },
        { duration: '5m', target: 300 },
        { duration: '5m', target: 300 },
        { duration: '5m', target: 400 },
        { duration: '5m', target: 500 },
        { duration: '5m', target: 500 },
        { duration: '5m', target: 600 },
        { duration: '5m', target: 600 },
        { duration: '5m', target: 0 },
    ],

};

export default function() {
    let res = http.get('http://poc-ms-go-load-balancer-982180119.us-east-2.elb.amazonaws.com:9000');
    //let res = http.get('http://localhost:9000');
    check(res, { 'status was 200': r => r.status === 200 });
    sleep(1);
}