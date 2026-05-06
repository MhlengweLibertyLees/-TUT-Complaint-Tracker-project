/**
 * TUT Complaint Tracker – Professional JavaScript
 * No emojis, fully responsive enhancements
 */
document.addEventListener('DOMContentLoaded', function () {

    // ── Auto-dismiss success alerts after 5 seconds ──────────
    const successAlerts = document.querySelectorAll('.alert-success');
    successAlerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 5000);
    });

    // ── Confirm dialogs for destructive actions ───────────────
    document.querySelectorAll('[data-confirm]').forEach(btn => {
        btn.addEventListener('click', (e) => {
            const msg = btn.getAttribute('data-confirm') || 'Are you sure?';
            if (!confirm(msg)) e.preventDefault();
        });
    });

    // ── Character counter for textareas ───────────────────────
    document.querySelectorAll('textarea[data-maxlength]').forEach(ta => {
        const maxLen = parseInt(ta.getAttribute('data-maxlength'), 10);
        const counter = document.createElement('div');
        counter.className = 'text-muted mt-1';
        counter.style.fontSize = '0.75rem';
        counter.style.textAlign = 'right';
        ta.parentNode.insertBefore(counter, ta.nextSibling);

        function updateCounter() {
            const remaining = maxLen - ta.value.length;
            counter.textContent = remaining + ' characters remaining';
            counter.style.color = remaining < 50 ? '#c0392b' : '';
        }
        ta.addEventListener('input', updateCounter);
        updateCounter();
    });

    // ── Highlight active nav link ────────────────────────────
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-menu a').forEach(link => {
        if (link.href && currentPath !== '/' && currentPath.includes(link.getAttribute('href'))) {
            link.classList.add('active');
        }
    });

    // ── Animated stat counters ───────────────────────────────
    document.querySelectorAll('.stat-number[data-value]').forEach(el => {
        const target = parseInt(el.getAttribute('data-value'), 10);
        let current = 0;
        const step = Math.max(1, Math.floor(target / 30));
        const timer = setInterval(() => {
            current += step;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            el.textContent = current;
        }, 30);
    });

    // ── Dynamic badge styling ─────────────────────────────────
    document.querySelectorAll('.badge[data-status]').forEach(badge => {
        const status = badge.getAttribute('data-status').toLowerCase().replace(/_/g, '-');
        badge.classList.add('badge-' + status);
    });

    // ── Client-side form validation (required fields) ────────
    document.querySelectorAll('form[data-validate]').forEach(form => {
        form.addEventListener('submit', (e) => {
            let isValid = true;
            form.querySelectorAll('[required]').forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = '#c0392b';
                    isValid = false;
                } else {
                    field.style.borderColor = '';
                }
            });
            if (!isValid) {
                e.preventDefault();
                const firstInvalid = form.querySelector('[required]:invalid');
                if (firstInvalid) firstInvalid.focus();
            }
        });
    });
});