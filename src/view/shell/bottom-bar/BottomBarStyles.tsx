import {StyleSheet} from 'react-native'

import {colors} from 'lib/styles'

export const styles = StyleSheet.create({
  bottomBar: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    flexDirection: 'row',
    alignItems: 'center',
    borderTopWidth: 1,
    paddingLeft: 5,
    paddingRight: 10,
  },
  bottomBarWeb: {
    // @ts-ignore web-only
    position: 'fixed',
  },
  ctrl: {
    flex: 1,
    paddingTop: 13,
    paddingBottom: 4,
  },
  notificationCount: {
    position: 'absolute',
    left: '52%',
    top: 8,
    backgroundColor: colors.blue3,
    paddingHorizontal: 4,
    paddingBottom: 1,
    borderRadius: 6,
    zIndex: 1,
  },
  notificationCountLight: {
    borderColor: colors.white,
  },
  notificationCountDark: {
    borderColor: colors.gray8,
  },
  notificationCountLabel: {
    fontSize: 12,
    fontWeight: 'bold',
    color: colors.white,
    fontVariant: ['tabular-nums'],
  },
  ctrlIcon: {
    marginLeft: 'auto',
    marginRight: 'auto',
  },
  ctrlIconSizingWrapper: {
    height: 28,
  },
  homeIcon: {},
  feedsIcon: {},
  searchIcon: {},
  bellIcon: {},
  profileIcon: {
    borderRadius: 100,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  messagesIcon: {},
  onProfile: {
    borderWidth: 1,
    borderRadius: 100,
  },
})
