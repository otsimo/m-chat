
export function resetTo(screen, target, params) {
  screen.props.navigation.dispatch({
    type: 'Navigation/RESET',
    index: 0,
    actions: [{ type: 'Navigation/NAVIGATE', routeName: target, params }],
  });
}
