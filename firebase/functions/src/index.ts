import * as functions from 'firebase-functions';

// Phase 1: Cloud Function stubs
// These will be implemented in Phase 2 with image extraction, notifications, etc.

/**
 * Stub: Triggered when a new log image is uploaded to Storage.
 * Phase 2: Will call Google Cloud Vision / Gemini Vision API to extract
 * odometer readings, fuel levels, and receipt amounts.
 */
export const onLogImageUploaded = functions.storage
  .object()
  .onFinalize(async (object) => {
    const filePath = object.name;
    if (!filePath) return;

    // Phase 1: No-op stub
    // Phase 2: Parse companyId + logId from filePath
    // Call Vision API, write extracted values back to Firestore log doc
    console.log(`[STUB] Log image uploaded: ${filePath}`);
  });

/**
 * Stub: Archive location pings older than 90 days.
 * Phase 2: Move to cold storage / BigQuery for analytics.
 */
export const archiveOldLocationPings = functions.pubsub
  .schedule('every 24 hours')
  .onRun(async (_context) => {
    // Phase 1: No-op stub
    console.log('[STUB] Archive old location pings — not yet implemented');
  });

/**
 * Stub: Send FCM push notification to driver when manager takes action.
 * Phase 2: Will be triggered by Firestore writes on logs or assignments.
 */
export const onManagerAction = functions.firestore
  .document('logs/{logId}')
  .onUpdate(async (change, _context) => {
    // Phase 1: No-op stub
    const after = change.after.data();
    console.log(`[STUB] Log updated: ${after?.logId}`);
  });
