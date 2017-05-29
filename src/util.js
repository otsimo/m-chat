
export function resetTo(screen, target, params) {
  screen.props.navigation.dispatch({
    type: 'Navigation/RESET',
    index: 0,
    actions: [{ type: 'Navigation/NAVIGATE', routeName: target, params }],
  });
}

let preTarget = null;

export function navigateTo(screen, target, params) {
  if (preTarget !== target) {
    preTarget = target;
    screen.props.navigation.navigate(target, params);
    setTimeout(() => {
      preTarget = null;
    }, 500);
  }
}
