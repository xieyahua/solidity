
-------------------------------------------------------------1.创建一个名为Voting的合约-------------------------------------------------------
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // 候选人票数映射
    mapping(string => uint256) private _votes;
    // 候选人列表（用于实现重置功能）
    string[] private _candidates;
    // 投票事件
    event Voted(address indexed voter, string candidate);

    // 投票函数（自动记录新候选人）
    function vote(string memory candidate) public {
        if(_votes[candidate] == 0) {
            _candidates.push(candidate);
        }
        _votes[candidate] += 1;
        emit Voted(msg.sender, candidate);
    }

    // 查询票数
    function getVotes(string memory candidate) public view returns (uint256) {
        return _votes[candidate];
    }

    // 重置所有票数（需管理员权限）
    function resetVotes() public {
        for(uint i = 0; i < _candidates.length; i++) {
            delete _votes[_candidates[i]];
        }
        delete _candidates;
    }
}



------------------------------------------2.反转字符串 (Reverse String)----------------------------------------------------------------
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringReverser {
    function reverse(string memory _str) public pure returns (string memory) {
        bytes memory strBytes = bytes(_str);
        bytes memory reversed = new bytes(strBytes.length);
        
        for(uint i = 0; i < strBytes.length; i++) {
            reversed[i] = strBytes[strBytes.length - i - 1];
        }
        
        return string(reversed);
    }
}

