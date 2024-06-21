package saleson.common.view;

import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Locale;

public class FrontViewResolver extends InternalResourceViewResolver {
    protected View createView(String viewName, Locale locale) throws Exception {
        if (!this.canHandle(viewName, locale)) {
            return null;
        } else {
            String forwardUrl;
            if (viewName.startsWith("redirect:")) {
                forwardUrl = viewName.substring("redirect:".length());
                RedirectView view = new RedirectView(forwardUrl, this.isRedirectContextRelative(), this.isRedirectHttp10Compatible(), false);
                String[] hosts = this.getRedirectHosts();
                if (hosts != null) {
                    view.setHosts(hosts);
                }

                return this.applyLifecycleMethods("redirect:", view);
            } else if (viewName.startsWith("forward:")) {
                forwardUrl = viewName.substring("forward:".length());
                InternalResourceView view = new InternalResourceView(forwardUrl);
                return this.applyLifecycleMethods("forward:", view);
            } else {
                return super.createView(viewName, locale);
            }
        }
    }
}
