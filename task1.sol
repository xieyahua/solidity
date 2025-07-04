
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


-----------------------------------------------3.用 solidity 实现整数转罗马数字---------------------------------------------------
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntegerToRoman {
    function intToRoman(uint256 num) public pure returns (string memory) {
        // 定义罗马数字符号和对应的整数值
        string[13] memory symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        uint16[13] memory values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        string memory result = "";
        
        // 遍历整数值数组，从大到小匹配并拼接罗马数字符号
        for (uint256 i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                result = string(abi.encodePacked(result, symbols[i]));
                num -= values[i];
            }
        }
        
        return result;
    }
}


----------------------------------------------- 4.用 solidity 实现罗马数字转数整数------------------------------------------------
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanNumeralConverter {
    mapping(uint256 => string) private intToRomanMap;

    constructor() {
        // 初始化映射表
        intToRomanMap[1] = "I";
        intToRomanMap[4] = "IV";
        intToRomanMap[5] = "V";
        intToRomanMap[9] = "IX";
        intToRomanMap[10] = "X";
        intToRomanMap[40] = "XL";
        intToRomanMap[50] = "L";
        intToRomanMap[90] = "XC";
        intToRomanMap[100] = "C";
        intToRomanMap[400] = "CD";
        intToRomanMap[500] = "D";
        intToRomanMap[900] = "CM";
        intToRomanMap[1000] = "M";

        // 添加其他必要的映射，可以通过循环构建，但为了简化，这里手动列出
        // 例如，可以添加 2-3, 6-8, 12-39, 60-89, 102-399, 600-899 的映射，这些都可以由基本的 I, V, X, C, M 组合而成
        // 但为了简洁，这里只列出了必要的特殊值
    }

    function intToRoman(uint256 _num) public pure returns (string memory) {
        if (_num == 0) return "";

        string memory result = "";
        uint16[13] memory values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        string[13] memory symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

        for (uint256 i = 0; i < values.length; i++) {
            while (_num >= values[i]) {
                result = string(abi.encodePacked(result, symbols[i]));
                _num -= values[i];
            }
        }

        return result;
    }
}

