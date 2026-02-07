import boa


def test_supports_interface():
    contract = boa.load("contracts/Basic.vy")

    # Verificamos nuestra interfaz FooBar
    assert contract.supportsInterface(bytes.fromhex("6e7f1a90"))
    # Verificamos el estándar ERC-165
    assert contract.supportsInterface(bytes.fromhex("01ffc9a7"))
    # Verificamos una interfaz aleatoria (debe ser False)
    assert not contract.supportsInterface(bytes.fromhex("ffffffff"))
