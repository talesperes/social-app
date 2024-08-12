import React from 'react'
import {StyleProp, ViewStyle} from 'react-native'
import {requireNativeModule, requireNativeViewManager} from 'expo-modules-core'

import {HLSDownloadViewProps} from './types'

const NativeModule = requireNativeModule('ExpoHLSDownload')
const NativeView: React.ComponentType<
  HLSDownloadViewProps & {
    ref: React.RefObject<any>
    style: StyleProp<ViewStyle>
  }
> = requireNativeViewManager('ExpoHLSDownload')

export default class HLSDownloadView extends React.PureComponent<HLSDownloadViewProps> {
  private nativeRef: React.RefObject<any> = React.createRef()

  constructor(props: HLSDownloadViewProps) {
    super(props)
  }

  static isAvailable(): boolean {
    return NativeModule.isAvailable()
  }

  async startDownloadAsync(sourceUrl: string): Promise<void> {
    return await this.nativeRef.current.startDownloadAsync(sourceUrl)
  }

  async cancelAsync(sourceUrl: string): Promise<void> {
    return await this.nativeRef.current.cancelAsync(sourceUrl)
  }

  render() {
    return (
      <NativeView
        ref={this.nativeRef}
        style={{height: 400, width: 300}}
        {...this.props}
      />
    )
  }
}