<template>
  <footer class="app-footer">
    <div class="app-footer-border app-footer-border-top">
      <div class="app-footer-border-left" />
      <div class="app-footer-border-right" />
    </div>
    <div class="app-footer-inner">
      <div class="app-footer-inner-border app-footer-inner-border-top">
        <div class="app-footer-inner-border-bg" />
      </div>
      <div class="app-footer-item">
        <a
          v-tooltip="'Roberts Space Industries'"
          href="https://robertsspaceindustries.com/"
          target="_blank"
          rel="noopener"
        >
          RSI
        </a>
        |
        <router-link :to="{ name: 'privacy-policy' }">
          {{ $t('nav.privacyPolicy') }}
        </router-link>
        |
        <router-link :to="{ name: 'impressum' }">
          {{ $t('nav.impressum') }}
        </router-link>
        <span class="d-xs-none">
          |
        </span>
        <br class="d-sm-none" />
        <a
          v-tooltip="'Twitter'"
          href="https://twitter.com/FleetYardsNet"
          target="_blank"
          rel="noopener"
          aria-label="Twitter"
        >
          <i class="fab fa-twitter" />
        </a>
        |
        <a
          v-tooltip="'Github'"
          href="https://github.com/fleetyards"
          target="_blank"
          rel="noopener"
          aria-label="Github"
        >
          <i class="fab fa-github" />
        </a>
        |
        <a
          v-tooltip="'Discord'"
          href="https://discord.gg/6EQKAsb"
          target="_blank"
          rel="noopener"
          aria-label="Discrod"
        >
          <i class="fab fa-discord" />
        </a>
        |
        <a
          v-tooltip="'Instagram'"
          href="https://www.instagram.com/fleetyardsnet/"
          target="_blank"
          rel="noopener"
          aria-label="Instagram"
        >
          <i class="fab fa-instagram" />
        </a>
        |
        <a href="https://api.fleetyards.net" target="_blank" rel="noopener">
          {{ $t('nav.api') }}
        </a>
      </div>
      <div class="app-footer-support">
        {{ $t('labels.supportUs') }}
        <a
          href="https://paypal.me/pools/c/83jQLadz60"
          target="_blank"
          rel="noopener"
        >
          <i class="fab fa-paypal" />
          PayPal
        </a>
        {{ $t('labels.or') }}
        <a
          href="https://www.patreon.com/fleetyards"
          target="_blank"
          rel="noopener"
        >
          <i class="fab fa-patreon" />
          Patreon
        </a>
      </div>
      <div class="app-footer-item">
        <p>
          <span>Copyright &copy; {{ new Date().getFullYear() }}</span>
          {{ copyrightOwner }}
        </p>
        <p class="rsi-disclaimer">
          This is an unofficial Star Citizen fansite, not affiliated with the
          Cloud Imperium group of companies.
          <br />
          All content on this site not authored by its host or users are
          property of their respective owners.
          <br />
          Star Citizen®, Squadron 42®, Roberts Space Industries®, and Cloud
          Imperium® are
          <br />
          registered trademarks of Cloud Imperium Rights LLC. All rights
          reserved.
        </p>
      </div>
      <div class="app-community-logo">
        <img
          v-lazy="require('images/community-logo.png')"
          alt="community-logo"
        />
      </div>
      <div class="app-version">
        {{ codename }} ({{ version }})
        <span
          :class="{
            online: online,
          }"
          class="git-revision"
        >
          <span class="hidden">{{ gitRevision }}</span>
          <i class="far fa-fingerprint" />
        </span>
      </div>
    </div>
  </footer>
</template>

<script lang="ts">
import Vue from 'vue'
import { Component } from 'vue-property-decorator'
import { Getter } from 'vuex-class'

@Component<AppFooter>({})
export default class AppFooter extends Vue {
  @Getter('online') online: boolean

  @Getter('version', { namespace: 'app' }) version: string

  @Getter('codename', { namespace: 'app' }) codename: string

  @Getter('gitRevision', { namespace: 'app' }) gitRevision: string

  get copyrightOwner() {
    return window.COPYRIGHT_OWNER
  }
}
</script>
