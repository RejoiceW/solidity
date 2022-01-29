pragma solidity 0.4.23; //指定版本

contract MyToken {
    string public name= "My first token coin"; // 代币名称
    uint8 public decimals = 18; // 代币单位精确到小数点后的位数
    string public symbol = "NIUPI"; // 代币符号
    uint public totalSupply; // 代币的发行量

    // 转账Event和授权Event
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _ownner, address indexed _spender, uint256 _value);

    mapping (address => uint256) public balances; //余额Map
    mapping (address => mapping (address => uint256)) public allowed; // 授权Map

    // constructor是solidity构造函数的关键词
    constructor() public {
        totalSupply = 100; // 发行量初始化
        balances[msg.sender] = totalSupply; //将所有代币给予合约发布者的以太坊地址
    }

    // 根据地址获取代币余额
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    // 授权额度申请
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // 根据 _owner和_spender查询_owner给_spender授权了多少额度
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    // 代币转账
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != 0x0); // 限制收款地址不能是0
        require(balances[msg.sender] >= _value); //判断余额是否比value多
        require(balances[_to] + _value >= balances[_to]);
        balances[msg.sender] -= _value; // 减去转出者的余额
        balances[_to] += _value; // 增加收款者的余额
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}