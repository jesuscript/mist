/**
Gets the right IPC path

@module getIpcPath
*/

const log = require('../utils/logger').create('getIpcPath');

const Settings = require('../settings');


module.exports = function(nodeType) {
    var ipcPath = Settings.ipcPath;
    if (ipcPath) {
        return ipcPath;
    }
    
    var p = require('path');
    var path = Settings.userHomePath;

    var unknownNode = () => {
        throw new Error(`unknown node type: ${nodeType}`)
    }

    if(process.platform === 'darwin') {
        path += {
            geth: '/Library/Ethereum/geth.ipc',
            parity: '/.parity/jsonrpc.ipc'
        }[nodeType]  || unknownNode();
    }

    if(process.platform === 'freebsd' ||
       process.platform === 'linux' ||
       process.platform === 'sunos') {
        path += {
            geth:'/.ethereum/geth.ipc',
            parity: '/.parity/jsonrpc.ipc'
        }[nodeType]  || unknownNode();
    }

    if(process.platform === 'win32') {
        path = {
            geth: '\\\\.\\pipe\\geth.ipc'
        }[nodeType] || unknownNode();
    }
    
    log.debug(`IPC path: ${path}`);

    return path;
};
