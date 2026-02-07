# pragma version ==0.4.3

from .interfaces import FooBar
implementa: FooBar


_SUPPORTED_INTERFACES: constant(bytes4[2]) = [
    0x01ffc9a7,  # ID estándar para el propio ERC-165.
    0x6e7f1a90,  # ID calculado de la interfaz FooBar.
]

@external
@view
def supportsInterface(_interface_id: bytes4) -> bool:
    """
    @notice Consulta si el contrato implementa una interfaz específica.
    @dev Cumple con el estándar ERC-165.
    @param _interface_id El identificador de la interfaz.
    """
    return _interface_id in _SUPPORTED_INTERFACES


@external
@view
def calculate() -> uint256:
    return 0


@external
def test1(_target: address):
    assert _target != empty(address)
